extends PlayerBaseState

@export var inventory_interactor:InventoryInteractor

var _inventory_container:InventoryContainer = null

func on_enter() -> void:
	player.velocity = Vector2.ZERO
	player.animation_tree.get("parameters/playback").travel("Idle")
	_inventory_container = inventory_interactor.get_first_overlapping_inventory_container()
	player.inventory_opened.emit(_inventory_container.inventory)
	_inventory_container.inventory_opened.emit()

func on_input(event:InputEvent):
	if event.is_action_pressed("interact"):
		change_state("Idle")
		
func on_exit() -> void:
	_inventory_container.inventory_closed.emit()
	player.inventory_closed.emit()
