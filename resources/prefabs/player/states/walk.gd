extends PlayerBaseState

@export var _inventory_interactor:InventoryInteractor
@export var _item_interactor:ItemInteractor

var _player_direction:Vector2

func _ready():
	if _inventory_interactor == null:
		push_error("Set inventory interactor for state Walk")
	if _item_interactor == null:
		push_error("Set item interactor for state Walk")

func on_enter() -> void:
	player.animation_tree.get("parameters/playback").travel("Walk")
	
func on_physics_process(_delta: float) -> void:
	if _try_switch_item_pick_up():
		return
	if _try_switch_inventory_interaction():
		return
	_player_direction = player.get_input_vector_normalized()
	if not _try_switch_idle():
		_set_animation_tree_blend_position()

func _set_animation_tree_blend_position() -> void:
	player.animation_tree.set("parameters/Idle/blend_position", _player_direction)
	player.animation_tree.set("parameters/Walk/blend_position", _player_direction)

func _try_switch_idle() -> bool:
	player.velocity = _player_direction * player.speed
	if _player_direction == Vector2.ZERO:
		change_state("Idle")
		return true
	return false

func _try_switch_item_pick_up() -> bool:
	if _item_interactor.entering_item != null && Input.is_action_pressed("interact"):
		change_state("InventoryInteraction")
		return true
	return false
	
func _try_switch_inventory_interaction() -> bool:
	if _item_interactor.entering_item != null && Input.is_action_pressed("interact"):
		change_state("PickingUpItem")
		return true
	return false
