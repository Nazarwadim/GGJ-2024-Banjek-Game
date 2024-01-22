extends Node

@export var hot_bar:HotBar

func _input(event:InputEvent):
	if not (event is InputEventMouseButton and (event.is_action("next_hot_bar_slot") or event.is_action("previous_hot_bar_slot")) ):
		return
	var slot_index = hot_bar.get_current_slot_index()
	
	if  event.is_action("next_hot_bar_slot"):
		if slot_index == 0:
			slot_index = hot_bar.count_items - 0.5
		else:
			slot_index -= 0.5

	if event.is_action("previous_hot_bar_slot"):
		if slot_index == hot_bar.count_items - 0.5:
			slot_index = 0
		else:
			slot_index += 0.5
	hot_bar.set_current_item(slot_index)

func _on_gui_input(event:InputEvent, index:int) -> void:
	if not event is InputEventMouseButton or not event.is_action_pressed("select_item"):
		return
	hot_bar.set_current_item(index)


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
