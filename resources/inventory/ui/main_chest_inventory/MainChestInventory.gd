extends Control

signal current_slot_changed(index:int)
var _current_slot_index:int
@export var inventory:Inventory
@onready var inventory_ui :InventoryUI= $InventoryUI
@onready var current_item_label = $CurrentItemLabel

func _ready():
	inventory_ui.inventory = inventory
	inventory_ui.update()
	$MainChestInventoryHandler.connect_slots_input()

func set_current_item(index:int) -> void:
	_set_outline_by_index(index)
	if index != _current_slot_index:
		current_slot_changed.emit(index)
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
		var slot_before := grid_container.get_child( _current_slot_index )
		slot_before.disable_outline()
