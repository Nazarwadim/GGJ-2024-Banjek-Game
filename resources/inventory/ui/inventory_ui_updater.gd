class_name InventoryUIUpdater

var _inventory_ui:InventoryUI
var _slot = preload("slot.tscn")

func _init(inventory_ui:InventoryUI):
	_inventory_ui = inventory_ui

func update() -> void:
	var grid_items := _inventory_ui.grid_items_container.get_children()
	_update_slots_count(grid_items)
	_update_slots_texture(grid_items)
	
func _update_slots_count(grid_items:Array) -> void:
	if grid_items.size() == _inventory_ui.inventory.items.size():
		return
	_remove_slots(grid_items)
	_add_slots(grid_items)
	
func _remove_slots(grid_items:Array) -> void:
	for slot in grid_items:
		_inventory_ui.grid_items_container.remove_child(slot)
		slot.queue_free()
	grid_items.resize(0)
	
func _add_slots(grid_items:Array) -> void:
	for i in _inventory_ui.inventory.items.size():
		var slot := _slot.instantiate()
		_inventory_ui.grid_items_container.add_child(slot)
		grid_items.push_back(slot)

func _update_slots_texture(grid_items:Array) -> void:
	var i:int = 0
	for slot in grid_items:
		if _inventory_ui.inventory.items[i] != null:
			slot.item_texture.texture = _inventory_ui.inventory.items[i].texture
		else:
			slot.item_texture.texture = null
		i+=1

