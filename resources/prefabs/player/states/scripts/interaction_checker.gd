var _state

func _init(state:StateMachineState):
	_state = state

func can_switch_item_pick_up() -> bool:
	if not _state.item_interactor.get_first_overlapping_item_container() != null or not Input.is_action_just_pressed("pick_up_item"):
		return false
	if _state.inventory_container.inventory.find_first_free_cell() < 0:
		return false
	return true
	
func can_switch_inventory_interaction() -> bool:
	if _state.inventory_interactor.get_first_overlapping_inventory_container()  != null && Input.is_action_just_pressed("interact"):
		return true
	return false

func can_switch_droping_item() -> bool:
	var hot_bar_slot :int= _state.player.get_hot_bar_slot_index()
	if hot_bar_slot == -1:
		return false
	if _state.inventory_container.inventory.items[hot_bar_slot] == null:
		return false
	if not Input.is_action_just_pressed("drop_item"):
		return false
	return true
