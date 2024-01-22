class_name InventoryUIUpdater

var _inventory_ui:InventoryUI
var _slot = preload("slot.tscn")

func _init(inventory_ui:InventoryUI):
	_inventory_ui = inventory_ui

func update() -> void:
	_update_slots_count()
	_update_slots_texture()
	
	
func _update_slots_count() -> void:	
	if _inventory_ui.grid_items_container.get_child_count() == _inventory_ui.inventory.items.size():
		return
	_remove_slots()
	_add_slots()
	
func _remove_slots() -> void:
	var slots := _inventory_ui.grid_items_container.get_children()
	for slot in slots:
		slot.queue_free()
	
func _add_slots() -> void:
	for i in _inventory_ui.inventory.items.size():
		var slot := _slot.instantiate()
		_inventory_ui.grid_items_container.add_child(slot)

func _update_slots_texture() -> void:
	var slots := _inventory_ui.grid_items_container.get_children()
	var i:int = 0
	for slot in slots:
		if _inventory_ui.inventory.items[i] != null:
			slot.item_texture.texture = _inventory_ui.inventory.items[i].texture
		else:
			slot.item_texture.texture = null
		i+=1

