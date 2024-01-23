signal selected(slot_index)
signal double_selected(slot_index)
var slots:Array
var _grid_items_container:GridContainer
var _max_double_preased_time:int
var _preased_time_ms:int
var _index_before:int

func _init(grid_items_container:GridContainer, max_double_preased_time:int):
	_grid_items_container = grid_items_container
	_max_double_preased_time = max_double_preased_time
	_preased_time_ms = -max_double_preased_time

func _on_gui_input(event:InputEvent, index:int) -> void:
	if not event.is_action_pressed("select_item"):
		return
	selected.emit(index)
	_check_double_click(index)
	_index_before = index

func _check_double_click(index:int) -> void:
	if index == _index_before and Time.get_ticks_msec() - _preased_time_ms < _max_double_preased_time:
		double_selected.emit(index)
	_preased_time_ms = Time.get_ticks_msec()
	
func update_slots():
	slots = _grid_items_container.get_children()
	
func connect_slots_input() -> void:
	var i:int = 0
	for slot:Control in slots:
		slot.gui_input.connect(_on_gui_input.bind(i))
		i+=1
	
func disconnect_slots_input() -> void:
	var i:int = 0
	for slot:Control in slots:
		slot.gui_input.disconnect(_on_gui_input.bind(i))
		i+=1
