extends Control
class_name HotBar

@export var inventory :Inventory
@export var double_select_time_ms:int = 500

@onready var count_items :int= $InventoryUI.get_node("GridItemsContainer").columns
@onready var _inventory_ui :InventoryUI= $InventoryUI
@onready var current_item_label :Label= $CurrentItemLabel
@onready var current_item_texture = $CurrentItemTexture

signal current_slot_changed(index:int)

## emite only once, when item changed to another and double selected
signal select_double_clicked(index:int)

var _current_slot_index:float
var _timer_msec:int = - double_select_time_ms

func _ready() -> void:
	_inventory_ui.inventory = inventory
	_inventory_ui.open()
	_inventory_ui.update()
	$HotBarInputHandler.connect_slots_input()
	set_current_item(_current_slot_index)

func get_current_slot_index() -> float:
	return _current_slot_index

func update_inventory() -> void:
	_inventory_ui.update()
	set_current_item(_current_slot_index)

func set_current_item(index:float) -> void:
	_set_outline_by_index(index)
	_emit_signals_from_seting_current_item(index)
	
	_current_slot_index = index
	
	if inventory.items[floor(index)] == null:
		current_item_label.text = " "
		current_item_texture.texture = null
		return
	_set_current_itep_props(floor(index))

func _emit_signals_from_seting_current_item(index:float) -> void:
	if floor(index) != floor(_current_slot_index):
		current_slot_changed.emit(floor(index))
	elif index - _current_slot_index == 0 :
		if Time.get_ticks_msec() - _timer_msec < double_select_time_ms:
			select_double_clicked.emit(index)
	_timer_msec = Time.get_ticks_msec()		

func _set_current_itep_props(index:int) -> void:
	current_item_label.text = inventory.items[index].name
	current_item_texture.texture = inventory.items[index].texture

func _set_outline_by_index(index:float) -> void:
	var grid_container := $InventoryUI.get_node("GridItemsContainer")
	var slot := grid_container.get_child(floor(index))
	slot.enable_outline()
	if floor(_current_slot_index) != floor(index):
		var slot_before := grid_container.get_child(floor( _current_slot_index ))
		slot_before.disable_outline()
