extends PlayerBaseState

@export var area_using_item_detector:AreaUsingItemDetector
@export var inventory_container:InventoryContainer

@onready var _animation_switch_timer :Timer = $AnimationSwitchTimer
@onready var _using_item_timer :Timer= $UsingItemTimer

var _vector_to_using_area:Vector2 = Vector2.ZERO
var _is_interupted:bool = false
var _current_animation := "UsingItem"
var _current_using_item:Item

func _ready():
	_animation_switch_timer.timeout.connect(_on_animation_switch_timer_timeout)

func on_enter() -> void:
	_animation_switch_timer.start()
	_is_interupted = false
	var area_using_item := area_using_item_detector.get_first_overlapping_area_using_item()
	_set_up_vector_to_item(area_using_item)
	_set_animation_parameters()
	var hot_bar_using_slot := player.get_hot_bar_slot_index()
	_using_item_timer.timeout.connect(_on_area_using_timeout.bind(area_using_item, hot_bar_using_slot))
	_using_item_timer.start(area_using_item.time_to_use_ms/1000.0)
	player.item_start_using.emit(area_using_item.time_to_use_ms)
	_current_using_item = area_using_item.item_can_use
	
	
func on_input(_event: InputEvent) -> void:
	if player.get_input_vector_normalized() != Vector2.ZERO:
		_interrupt()

func on_exit() -> void:
	_animation_switch_timer.stop()
	_using_item_timer.timeout.disconnect(_on_area_using_timeout)
	_using_item_timer.stop()

func _on_animation_switch_timer_timeout() -> void:
	if _current_animation == "UsingItem":
		player.animation_tree.get("parameters/playback").travel("Idle")
		_current_animation = "Idle"
	elif _current_animation == "Idle":
		player.animation_tree.get("parameters/playback").travel("UsingItem")
		_current_animation = "UsingItem"

func _on_area_using_timeout(area_using_item:AreaUsingItem, hot_bar_using_slot:int) -> void:
	if _is_interupted:
		return
	_is_interupted = true
	inventory_container.inventory.items[hot_bar_using_slot] = null
	area_using_item.use()
	player.item_used.emit()
	change_state("Idle")
	
func _interrupt() -> void:
	if _is_interupted == false:
		player.item_using_interrupted.emit(_current_using_item)
		change_state("Walk")
		_is_interupted = true

func _set_up_vector_to_item(area_using_item:AreaUsingItem) -> void:
	_vector_to_using_area = (area_using_item.global_position - player.global_position).normalized()

func _set_animation_parameters() -> void:
	player.animation_tree.get("parameters/playback").travel("UsingItem")
	player.animation_tree.set("parameters/UsingItem/blend_position", _vector_to_using_area)
	player.animation_tree.set("parameters/Idle/blend_position", _vector_to_using_area)
