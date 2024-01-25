extends Control
signal current_slot_changed(index:int)

## emite only once, when item changed to another and double selected
signal select_double_clicked(index:int)

@export var inventory:Inventory

@onready var _inventory_ui = $InventoryUI
@onready var current_item_label = $InventoryUI/CurrentItemLabel

var _current_slot_index:int

func open_inventory(inventory_new) -> void:
	inventory = inventory_new
	_inventory_ui.inventory = inventory
	update_inventory()
	_inventory_ui.open()
	$MainChestInventoryHandler.connect_slots_input()

func close_inventory() -> void:
	inventory = null
	_inventory_ui.inventory = null
	_inventory_ui.close()
	$MainChestInventoryHandler.disconnect_slots_input()

func update_inventory() -> void:
	_inventory_ui.update()

func get_current_slot_index() -> float:
	return _current_slot_index

func set_current_item(index:int) -> void:
	_set_outline_by_index(index)
	if index != _current_slot_index:
		current_slot_changed.emit(floor(index))
	_current_slot_index = index
	
	if inventory.items[index] != null:
		current_item_label.text = inventory.items[index].name
	else :
		current_item_label.text = " "

func _set_outline_by_index(index:int) -> void:
	var grid_container := $InventoryUI.get_node("GridItemsContainer")
	var slot := grid_container.get_child(index)
	slot.enable_outline()
	if _current_slot_index != index:
		if _current_slot_index < grid_container.get_child_count():
			var slot_before := grid_container.get_child(_current_slot_index)
			slot_before.disable_outline()

func _on_player_inventory_opened(inventory_:Inventory):
	open_inventory(inventory_)

func _on_player_inventory_closed():
	close_inventory()
