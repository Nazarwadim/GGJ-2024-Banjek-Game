extends Control
class_name ItemMover
@export var main_chest_inventory_ui:Control
@export var hot_bar:Control

func _on_hot_bar_select_double_clicked(index:int) -> void:
	if hot_bar.inventory.items[index] == null or main_chest_inventory_ui.inventory == null:
		return
	var free_chest_cell = main_chest_inventory_ui.inventory.find_first_free_cell()
	if free_chest_cell == -1:
		return
	hot_bar.inventory.move_item_to_inventory(main_chest_inventory_ui.inventory, index, free_chest_cell)
	_update_inventories()

func _on_main_chest_inventory_select_double_clicked(index:int) -> void:
	if main_chest_inventory_ui.inventory.items[index] == null or hot_bar.inventory == null:
		return
	var free_chest_cell = hot_bar.inventory.find_first_free_cell()
	if free_chest_cell == -1:
		return
	main_chest_inventory_ui.inventory.move_item_to_inventory(hot_bar.inventory, index, free_chest_cell)
	_update_inventories()

func _update_inventories() -> void:
	main_chest_inventory_ui.update_inventory() 
	hot_bar.update_inventory()
