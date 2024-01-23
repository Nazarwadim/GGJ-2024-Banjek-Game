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


func _on_gui_input(event:InputEvent, index:int) -> void:
	if not event is InputEventMouseButton or not event.is_action_pressed("select_item"):
		return
	get_parent().set_current_item(index)
	
func disconnect_slots_input() -> void:
	_slots_observer.update_slots()
	_slots_observer.disconnect_slots_input()

func connect_slots_input() -> void:
	_slots_observer.update_slots()
	_slots_observer.connect_slots_input()
