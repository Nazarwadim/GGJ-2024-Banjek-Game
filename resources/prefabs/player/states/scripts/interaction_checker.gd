var _state

func _init(state:StateMachineState):
	_state = state

func can_switch_item_pick_up() -> bool:
	if not _state.item_interactor.entering_item != null or not Input.is_action_just_pressed("interact"):
		return false
	if _state.inventory_container.inventory.find_first_free_cell() < 0:
		return false
	return true
	
func can_switch_inventory_interaction() -> bool:
	if _state.inventory_interactor.entering_inventory != null && Input.is_action_just_pressed("interact"):
		print(_state.inventory_interactor.entering_inventory)
		return true
	return false

func can_switch_droping_item() -> bool:
	var hot_bar_slot :int= _state.player.get_hot_bar_slot_index()
	if hot_bar_slot == -1:
		return false
	if _state.inventory_container[hot_bar_slot] == null:
		return false
	if not Input.is_action_just_pressed("drop_item"):
		return false
	return true
