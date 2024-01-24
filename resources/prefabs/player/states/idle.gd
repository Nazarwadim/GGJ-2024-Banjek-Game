extends PlayerBaseState

@export var _inventory_interactor:InventoryInteractor
@export var _item_interactor:ItemInteractor

func _ready():
	if _inventory_interactor == null:
		push_error("Set inventory interactor for state Walk")
	if _item_interactor == null:
		push_error("Set item interactor for state Walk")

func on_enter() -> void:
	await get_tree().create_timer(get_process_delta_time()).timeout
	player.animation_tree.get("parameters/playback").travel("Idle")

func on_physics_process(_delta: float) -> void:
	if(_try_switch_item_pick_up()):
		return
	if(_try_switch_inventory_interaction()):
		return
	_try_switch_walk()
	

func _try_switch_walk() -> bool:
	var player_direction :Vector2 = player.get_input_vector_normalized()
	if player_direction != Vector2.ZERO:
		change_state("Walk")
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
