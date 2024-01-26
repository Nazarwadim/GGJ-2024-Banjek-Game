extends Control

@export var _hot_bar:Control

@export var _player_mood_sprite : Sprite2D
@onready var _hot_bar_inventory :Inventory = _hot_bar.inventory
# Mood priorities:
# Can`t use -> highest priority = 2
# Can use = 1
# Tip = 3
# standart nothing = 0

enum State
{
	Standart,
	CanUse,
	CantUse,
	Tip
}



var _area_using_item_containers:Array[Node] = []
var _chest_containers:Array[Node] = []
var _items:Array[Node] = []
var _slots:Array[Node] = []

var _blocked := false
var _current_state := State.Standart
var _current_area_using_item:AreaUsingItem

func _ready():
	await get_tree().create_timer(get_physics_process_delta_time() + 0.1).timeout
	_area_using_item_containers = get_tree().get_nodes_in_group("area_using_item_containers")
	_chest_containers = get_tree().get_nodes_in_group("chest_containers")
	_items = get_tree().get_nodes_in_group("items")
	_slots = get_tree().get_nodes_in_group("slots")
	
	for slot in _slots:
		slot.mouse_entered.connect(_on_item_ui_mouse_entered.bind(slot.item))
		slot.mouse_exited.connect(_on_item_ui_mouse_exited)
	
	for item in _items:
		item.mouse_entered.connect(_on_item_container_mouse_entered)
		item.mouse_exited.connect(_on_item_container_mouse_exited)
	
	for chest in _chest_containers:
		chest.mouse_entered.connect(_on_item_container_mouse_entered)
		chest.mouse_exited.connect(_on_item_container_mouse_exited)
	
	for area_using_item in _area_using_item_containers:
		area_using_item.mouse_entered.connect(_on_area_using_item_mouse_entered.bind(area_using_item))
		area_using_item.mouse_exited.connect(_on_area_using_item_mouse_exited)
	
	SignalBus.item_container_tree_entered.connect(_on_item_droped)
	SignalBus.slot_ui_tree_entered.connect(_on_slot_entered_tree)
	_hot_bar.current_slot_changed.connect(_on_hot_bar_slot_changed)
	_hot_bar.hot_bar_updated.connect(_on_hot_bar_updated)



#region PlayerMood
func _on_slot_entered_tree(slot:Control):
	slot.mouse_entered.connect(_on_item_ui_mouse_entered.bind(slot.item))
	slot.mouse_exited.connect(_on_item_ui_mouse_exited)

func _on_item_droped(item_container:CollisionObject2D):
	item_container.mouse_entered.connect(_on_item_container_mouse_entered)
	item_container.mouse_exited.connect(_on_item_container_mouse_exited)

func _on_item_ui_mouse_entered(item:Item) -> void:
	if item == null:
		return
	_current_state = State.Tip
	if not _blocked:
		_player_mood_sprite.frame = State.Tip

func _on_item_ui_mouse_exited() -> void:
	_current_state = State.Standart
	if not _blocked:
		_player_mood_sprite.frame = State.Standart

	
func _on_item_container_mouse_entered() -> void:
	_current_state = State.Tip
	if not _blocked:
		_player_mood_sprite.frame = State.Tip

func _on_item_container_mouse_exited() -> void:
	_current_state = State.Standart
	if not _blocked:
		_player_mood_sprite.frame = State.Standart


func _on_inventory_container_mouse_entered() -> void:
	_current_state = State.Tip
	if not _blocked:
		_player_mood_sprite.frame = State.Tip
	
func _on_inventory_container_mouse_exited() -> void:
	_current_state = State.Standart
	if not _blocked:
		_player_mood_sprite.frame = State.Standart

func _on_hot_bar_updated():
	_on_hot_bar_slot_changed(_hot_bar.get_current_slot_index())

func _on_hot_bar_slot_changed(slot_index:int):
	if _current_area_using_item != null:
		if _current_area_using_item.is_used:
			_current_state = State.Standart
		elif  _hot_bar_inventory.items[slot_index] != null &&\
		  _hot_bar_inventory.items[slot_index].name == _current_area_using_item.item_can_use.name:
			_current_state = State.CanUse
		elif _hot_bar_inventory.items[slot_index] != null:
			_current_state = State.CantUse
		else:
			_current_state = State.Tip
		if not _blocked:
			_player_mood_sprite.frame = _current_state

func _on_area_using_item_mouse_entered(item:AreaUsingItem) -> void:
	_current_area_using_item = item
	var hot_bar_index :int = _hot_bar.get_current_slot_index()
	if item.is_used:
		_current_state = State.Standart
	elif  _hot_bar_inventory.items[ hot_bar_index] != null &&\
		_hot_bar_inventory.items[hot_bar_index].name == _current_area_using_item.item_can_use.name:
		_current_state = State.CanUse
	elif _hot_bar_inventory.items[ hot_bar_index] != null:
		_current_state = State.CantUse
	else:
		_current_state = State.Tip
	if not _blocked:
		_player_mood_sprite.frame = _current_state
	
func _on_area_using_item_mouse_exited() -> void:
	_current_area_using_item = null
	_current_state = State.Standart
	if not _blocked:
		_player_mood_sprite.frame = _current_state

func set_player_cant_use_for_time(time_ms:int) -> void:
	if _blocked:
		return
	var temp_state := _current_state
	_current_state = State.CantUse
	_blocked = true
	_player_mood_sprite.frame = _current_state
	await get_tree().create_timer(time_ms * 1000).timeout
	_blocked = false
	_current_state = temp_state
	_player_mood_sprite.frame = _current_state

func set_player_can_use_for_time(time_ms:int) -> void:
	if _blocked:
		return
	var temp_state := _current_state
	_current_state = State.CanUse
	_blocked = true
	_player_mood_sprite.frame = _current_state
	await get_tree().create_timer(time_ms * 1000).timeout
	_blocked = false
	_current_state = temp_state
	_player_mood_sprite.frame = _current_state
#endregion
