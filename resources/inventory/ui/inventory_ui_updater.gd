class_name InventoryUIUpdater

var _inventory_ui:InventoryUI
var _slot = preload("slot.tscn")

func _init(inventory_ui:InventoryUI):
	_inventory_ui = inventory_ui

func update() -> void:
	_update_slots_count()
	_update_slots_texture()
	_update_frame_size()
	
	
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
		i+=1

func _update_frame_size() -> void:
	var items_count := _inventory_ui.grid_items_container.get_child_count()
	var columns := _inventory_ui.grid_items_container.columns
	var rows := items_count / columns + 1
	
	if items_count % columns == 0:
		rows -= 1
	
	var margine_size := Vector2(_inventory_ui.back_ground.patch_margin_left + _inventory_ui.back_ground.patch_margin_right,\
		_inventory_ui.back_ground.patch_margin_top + _inventory_ui.back_ground.patch_margin_bottom) 
	_inventory_ui.back_ground.size = \
		(_slot.instantiate().size + Vector2(6, 6)) * Vector2(columns, rows)\
		 + margine_size
