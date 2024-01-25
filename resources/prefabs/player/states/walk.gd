extends PlayerBaseState

@export var inventory_interactor:InventoryInteractor
@export var item_interactor:ItemInteractor
@export var inventory_container:InventoryContainer

@onready var _interaction_state_checker = preload("res://resources/prefabs/player/states/scripts/interaction_checker.gd").new(self)
var _player_direction:Vector2

func _ready():
	if inventory_interactor == null:
		push_error("Set inventory interactor for state Walk")
	if item_interactor == null:
		push_error("Set item interactor for state Walk")
	if inventory_container == null:
		push_error("Set inventory container for state Walk")

func on_enter() -> void:
	player.animation_tree.get("parameters/playback").travel("Walk")
	
func on_physics_process(_delta: float) -> void:
	_player_direction = player.get_input_vector_normalized()
	player.velocity = _player_direction * player.speed
	if not _try_switch_idle():
		_set_animation_tree_blend_position()

func on_input(_input:InputEvent):
	if _interaction_state_checker.can_switch_item_pick_up():
		change_state("PickingUpItem")
	elif _interaction_state_checker.can_switch_inventory_interaction():
		change_state("InventoryInteraction")
	elif _interaction_state_checker.can_switch_droping_item():
		change_state("DropingItem")

func _set_animation_tree_blend_position() -> void:
	player.animation_tree.set("parameters/Idle/blend_position", _player_direction)
	player.animation_tree.set("parameters/Walk/blend_position", _player_direction)

func _try_switch_idle() -> bool:
	if _player_direction == Vector2.ZERO:
		change_state("Idle")
		return true
	return false
