extends PlayerBaseState

@export var inventory_interactor:InventoryInteractor
@export var item_interactor:ItemInteractor
@export var inventory_container:InventoryContainer
@export var area_using_item_detector:AreaUsingItemDetector

var _interaction_state_checker = preload("res://resources/prefabs/player/states/scripts/interaction_checker.gd").new(self)
var _player_direction:Vector2

func _ready():
	if inventory_interactor == null:
		push_error("Set inventory interactor for state Walk")
	if item_interactor == null:
		push_error("Set item interactor for state Walk")
	if inventory_container == null:
		push_error("Set inventory container for state Walk")

func on_enter() -> void:
	player.gpu_particles_2d.emitting = true
	player.animation_tree.get("parameters/playback").travel("Walk")
	
func on_physics_process(_delta: float) -> void:
	_player_direction = player.get_input_vector_normalized()
	player.velocity = _player_direction * player.speed
	if not _try_switch_idle():
		_set_animation_tree_blend_position()

func on_input(input:InputEvent):
	if input.is_action_pressed("drop_item") and not _interaction_state_checker.can_switch_droping_item():
		player.can_not_drop.emit()
	elif input.is_action_pressed("pick_up_item") and not _interaction_state_checker.can_switch_item_pick_up():
		player.can_not_pick_up.emit()
	elif input.is_action_pressed("interact"):
		var area_using_item := area_using_item_detector.get_first_overlapping_area_using_item()
		if area_using_item != null:
			player.can_not_use.emit(Player.ErrorCanNotUseItem.PlayerIsMoving)
			
	if _interaction_state_checker.can_switch_item_pick_up():
		change_state("PickingUpItem")
	elif _interaction_state_checker.can_switch_inventory_interaction():
		change_state("InventoryInteraction")
	elif _interaction_state_checker.can_switch_droping_item():
		change_state("DropingItem")

func on_exit() -> void:
	player.gpu_particles_2d.emitting = false

func _set_animation_tree_blend_position() -> void:
	player.animation_tree.set("parameters/Idle/blend_position", _player_direction)
	player.animation_tree.set("parameters/Walk/blend_position", _player_direction)

func _try_switch_idle() -> bool:
	if _player_direction == Vector2.ZERO:
		change_state("Idle")
		return true
	return false
