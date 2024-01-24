extends PlayerBaseState

@export var inventory_container:InventoryContainer
@export var item_interactor:ItemInteractor

var _vector_to_item:Vector2
func on_enter() -> void:
	player.velocity = Vector2.ZERO
	_set_up_vector_to_item()
	_set_animation_parameters()
	player.animation_tree.animation_finished.connect(func(_anim_name):
		change_state("Idle")
		_add_item_to_inventory())
	

func _add_item_to_inventory() -> void:
	var first_free_cell:int = inventory_container.inventory.find_first_free_cell()
	print(item_interactor.entering_item)
	inventory_container.inventory.items[first_free_cell] = item_interactor.entering_item.item
	item_interactor.entering_item.pick_item()
	player.item_picked.emit()

func _set_up_vector_to_item() -> void:
	_vector_to_item = (item_interactor.entering_item.position - player.position).normalized()
	_vector_to_item.y = -_vector_to_item.y

func _set_animation_parameters() -> void:
	player.animation_tree.get("parameters/playback").travel("UsingItem")
	player.animation_tree.set("parameters/UsingItem/blend_position", _vector_to_item)
