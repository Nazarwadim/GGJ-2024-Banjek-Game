extends PlayerBaseState

@export var inventory_interactor:InventoryInteractor
func on_enter() -> void:
	player.velocity = Vector2.ZERO
	player.animation_tree.get("parameters/playback").travel("Idle")
	player.inventory_opened.emit(inventory_interactor.entering_inventory)
	inventory_interactor.entering_inventory.inventory_opened.emit()

func on_input(event:InputEvent):
	if event.is_action_pressed("interact"):
		change_state("Idle")
		
func on_exit() -> void:
	inventory_interactor.entering_inventory.inventory_closed.emit()
	player.inventory_closed.emit()
