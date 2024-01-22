extends Node

func _on_gui_input(event:InputEvent, index:int) -> void:
	if not event is InputEventMouseButton or not event.is_action_pressed("select_item"):
		return
	get_parent().set_current_item(index)
	
func connect_slots_input() -> void:
	var slots := $"../InventoryUI".get_node("GridItemsContainer").get_children()
	var i:int = 0
	for slot:Control in slots:
		slot.gui_input.connect(_on_gui_input.bind(i))
		i+=1
	
func disconnect_slots_input() -> void:
	var slots := $"../InventoryUI".get_node("GridItemsContainer").get_children()
	var i:int = 0
	for slot:Control in slots:
		slot.gui_input.disconnect(_on_gui_input.bind(i))
		i+=1
