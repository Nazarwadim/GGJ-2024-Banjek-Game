extends PlayerBaseState

@export var inventory_interactor:InventoryInteractor
@export var item_interactor:ItemInteractor
@export var inventory_container:InventoryContainer
@export var area_using_item_detector:AreaUsingItemDetector

var _interaction_state_checker = preload("res://resources/prefabs/player/states/scripts/interaction_checker.gd").new(self)

func _ready():
	if inventory_interactor == null:
		push_error("Set inventory interactor for state Idle")
	if item_interactor == null:
		push_error("Set item interactor for state Ilde")
	if inventory_container == null:
		push_error("Set inventory container for state Idle")

func on_enter() -> void:
	player.velocity = Vector2.ZERO
	player.animation_tree.get("parameters/playback").travel("Idle")

func on_input(input:InputEvent):
	if input.is_action_pressed("drop_item") and not _interaction_state_checker.can_switch_droping_item():
		player.can_not_drop.emit()
	elif input.is_action_pressed("pick_up_item") and not _interaction_state_checker.can_switch_item_pick_up():
		player.can_not_pick_up.emit()
	
	if _interaction_state_checker.can_switch_item_pick_up():
		change_state("PickingUpItem")
	elif _interaction_state_checker.can_switch_inventory_interaction():
		change_state("InventoryInteraction")
	elif _interaction_state_checker.can_switch_droping_item():
		change_state("DropingItem")
		
	elif input.is_action_pressed("interact"):
		var area_using_item := area_using_item_detector.get_first_overlapping_area_using_item()
		if _can_switch_using_item_if_preased_interact(area_using_item):
			change_state("UsingItem")
		elif area_using_item != null:
			var why := _get_player_error_can_not_use_if_area_using_item_null(area_using_item)
			player.can_not_use.emit(why) 
	elif _can_switch_walk():
		change_state("Walk")
	
func _can_switch_using_item_if_preased_interact(area_using_item) -> bool:
	if area_using_item == null:
		return false
	var hot_bar_slot_index := player.get_hot_bar_slot_index()
	if inventory_container.inventory.items[hot_bar_slot_index] == null:
		return false
	var current_hot_bar_item_name := inventory_container.inventory.items[hot_bar_slot_index].name
	if area_using_item.item_can_use.name != current_hot_bar_item_name:
		return false
	if area_using_item.is_used:
		return false
	return true
	
func _get_player_error_can_not_use_if_area_using_item_null(area_using_item) -> Player.ErrorCanNotUseItem:
	var hot_bar_slot_index := player.get_hot_bar_slot_index()
	if inventory_container.inventory.items[hot_bar_slot_index] == null:
		return Player.ErrorCanNotUseItem.EmptyItemInHotBar
	return Player.ErrorCanNotUseItem.UnsuitableItem
	

func _can_switch_walk() -> bool:
	var player_direction :Vector2 = player.get_input_vector_normalized()
	if player_direction != Vector2.ZERO:
		return true
	return false
