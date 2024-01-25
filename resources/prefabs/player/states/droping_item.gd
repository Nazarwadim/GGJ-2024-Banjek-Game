extends PlayerBaseState

@export var item_container_factory:ItemContainerFactory
@export var inventory_container:InventoryContainer

func on_enter() -> void:
	var hot_bar_slot :int= player.get_hot_bar_slot_index()
	var slot := inventory_container.inventory.items[hot_bar_slot]
	player.animation_tree.animation_finished.connect\
		(_on_droping_animation_finished.bind(hot_bar_slot, slot))
	_set_up_animation_parameters()
	player.velocity = Vector2.ZERO
	
func _set_up_animation_parameters() -> void:
	var velocity = player.animation_tree.get("parameters/Idle/blend_position")
	player.animation_tree.set("parameters/UsingItem/blend_position", velocity)
	player.animation_tree.get("parameters/playback").travel("UsingItem")

func _on_droping_animation_finished(_anim_name, hot_bar_slot:int, item:Item) -> void:
	_add_child_to_scene(item.name)
	_remove_item_from_inventory(hot_bar_slot)
	player.item_droped.emit()
	change_state("Idle")

func _remove_item_from_inventory(hot_bar_slot:int) -> void:
	inventory_container.inventory.items[hot_bar_slot] = null

func _add_child_to_scene(item_name) -> void:
	var item_container := item_container_factory.get_item(item_name)
	item_container.position = player.position
	if player.items_spawn_node != null:
		player.items_spawn_node.add_child(item_container)
	else :
		get_tree().root.add_child(item_container)

func on_exit() -> void:
	player.animation_tree.animation_finished.disconnect(_on_droping_animation_finished)
