extends PlayerBaseState

@export var inventory_interactor:InventoryInteractor
@export var item_interactor:ItemInteractor
@export var inventory_container:InventoryContainer

@onready var _interaction_state_checker = preload("res://resources/prefabs/player/states/scripts/interaction_checker.gd").new(self)

func _ready():
	if inventory_interactor == null:
		push_error("Set inventory interactor for state Idle")
	if item_interactor == null:
		push_error("Set item interactor for state Ilde")
	if inventory_container == null:
		push_error("Set inventory container for state Idle")

func on_enter() -> void:
	player.velocity = Vector2.ZERO
	player.animation_tree.get("parameters/playback").travel("Idle")

func on_physics_process(_delta: float) -> void:	
	_try_switch_walk()

func on_input(_input:InputEvent):
	if _interaction_state_checker.can_switch_item_pick_up():
		change_state("PickingUpItem")
	elif _interaction_state_checker.can_switch_inventory_interaction():
		change_state("InventoryInteraction")
	elif _interaction_state_checker.can_switch_droping_item():
		change_state("DropingItem")

func _try_switch_walk() -> bool:
	var player_direction :Vector2 = player.get_input_vector_normalized()
	if player_direction != Vector2.ZERO:
		change_state("Walk")
		return true
	return false
