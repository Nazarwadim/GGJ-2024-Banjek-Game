extends PlayerBaseState

@export var inventory_container:InventoryContainer
@export var item_interactor:ItemInteractor

var _vector_to_item:Vector2 = Vector2.ZERO

func on_enter() -> void:
	player.velocity = Vector2.ZERO
	var item = item_interactor.get_first_overlapping_item_container()
	_set_up_vector_to_item(item)
	_set_animation_parameters()
	await  player.animation_tree.animation_finished
	change_state("Idle")
	_add_item_to_inventory(item)

func _add_item_to_inventory(item) -> void:
	var first_free_cell:int = inventory_container.inventory.find_first_free_cell()
	inventory_container.inventory.items[first_free_cell] = item.item
	item.pick_item()
	player.item_picked.emit()

func _set_up_vector_to_item(item) -> void:
	_vector_to_item = (item.position - player.position).normalized()

func _set_animation_parameters() -> void:
	player.animation_tree.get("parameters/playback").travel("UsingItem")
	player.animation_tree.set("parameters/UsingItem/blend_position", _vector_to_item)
