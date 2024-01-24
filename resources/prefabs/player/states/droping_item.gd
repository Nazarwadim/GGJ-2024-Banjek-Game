extends PlayerBaseState

@export var item_container_factory:ItemContainerFactory
@export var inventory_container:InventoryContainer

func on_enter() -> void:
	player.animation_tree.animation_finished.connect(_on_droping_animation_finished)
	_set_up_animation_parameters()
	player.velocity = Vector2.ZERO
	
func _set_up_animation_parameters() -> void:
	var velocity = player.velocity.normalized()
	velocity.y = - velocity.y
	player.animation_tree.set("parameters/UsingItem/blend_position", velocity)
	player.animation_tree.get("parameters/playback").travel("UsingItem")

func _on_droping_animation_finished(_anim_name) -> void:
	_add_child_to_scene()
	_remove_item_from_inventory()
	player.item_droped.emit()
	change_state("Idle")

func _remove_item_from_inventory() -> void:
	var hot_bar_slot :int= player.get_hot_bar_slot_index()
	inventory_container.inventory.items[hot_bar_slot] = null

func _add_child_to_scene() -> void:
	var hot_bar_slot :int= player.get_hot_bar_slot_index()
	var item_name := inventory_container.inventory.items[hot_bar_slot].name
	var item_container := item_container_factory.get_item(item_name)
	item_container.position = player.position
	if player.items_spawn_node != null:
		player.items_spawn_node.add_child(item_container)
	else :
		get_tree().root.add_child(item_container)

func on_exit() -> void:
	player.animation_tree.animation_finished.disconnect(_on_droping_animation_finished)
