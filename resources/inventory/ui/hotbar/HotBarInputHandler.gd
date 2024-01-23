extends Node

var SlotsObserver = preload("res://resources/inventory/ui/slots_observer.gd")

@export var max_double_preased_time := 600
@onready var _slots_observer = SlotsObserver.new($"../InventoryUI".grid_items_container, max_double_preased_time)

func _ready():
	_slots_observer.selected.connect(_on_slot_selected)
	_slots_observer.double_selected.connect(_on_slot_double_preased)

func _on_slot_double_preased(slot:int) -> void:
	get_parent().select_double_clicked.emit(slot)

func _on_slot_selected(index):
	get_parent().set_current_item(index)
	
func _input(event:InputEvent):
	if not (event is InputEventMouseButton and (event.is_action("next_hot_bar_slot") or event.is_action("previous_hot_bar_slot")) ):
		return
	var slot_index = get_parent().get_current_slot_index()
	
	if  event.is_action("next_hot_bar_slot"):
		if slot_index == 0:
			slot_index = get_parent().count_items - 0.5
		else:
			slot_index -= 0.5

	if event.is_action("previous_hot_bar_slot"):
		if slot_index == get_parent().count_items - 0.5:
			slot_index = 0
		else:
			slot_index += 0.5
	get_parent().set_current_item(slot_index)

func connect_slots_input() -> void:
	_slots_observer.update_slots()
	_slots_observer.connect_slots_input()
