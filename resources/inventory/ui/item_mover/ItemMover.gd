extends Control

@export var main_chest_inventory_ui:MainChestInventoryUI
@export var hot_bar:HotBar

func _on_hot_bar_select_double_clicked(index:int) -> void:
	if hot_bar.inventory.items[index] == null:
		return
	var free_chest_cell = _find_first_free_cell_in_inventory(main_chest_inventory_ui.inventory)
	if free_chest_cell == -1:
		return
	hot_bar.inventory.move_item_to_inventory(main_chest_inventory_ui.inventory, index, free_chest_cell)
	_update_inventories()

func _on_main_chest_inventory_select_double_clicked(index:int) -> void:
	if main_chest_inventory_ui.inventory.items[index] == null:
		return
	var free_chest_cell = _find_first_free_cell_in_inventory(hot_bar.inventory)
	if free_chest_cell == -1:
		return
	main_chest_inventory_ui.inventory.move_item_to_inventory(hot_bar.inventory, index, free_chest_cell)
	_update_inventories()

func _find_first_free_cell_in_inventory(inventory:Inventory) -> int:
	var iteration:int = 0
	for item in inventory.items:
		if item == null:
			return iteration
		iteration +=1
	return -1

func _update_inventories() -> void:
	main_chest_inventory_ui.update_inventory() 
	hot_bar.update_inventory()
