extends Sprite2D
@export var _hot_bar:Control


# Mood priorities:
# Can`t use -> highest priority = 2
# Can use = 1
# Tip = 3
# standart nothing = 0
enum State
{
	Standart,
	CanUse,
	CantUse,
	Tip
}





#func _on_slot_entered_tree(slot:Control):
	#slot.mouse_entered.connect(_on_item_ui_mouse_entered.bind(slot.item))
	#slot.mouse_exited.connect(_on_item_ui_mouse_exited)
#
#func _on_item_droped(item_container:CollisionObject2D):
	#item_container.mouse_entered.connect(_on_item_container_mouse_entered)
	#item_container.mouse_exited.connect(_on_item_container_mouse_exited)
#
#func _on_item_ui_mouse_entered(item:Item) -> void:
	#if item == null:
		#return
	#_current_state = State.Tip
	#if not _blocked:
		#_player_mood_sprite.frame = State.Tip
#
#func _on_item_ui_mouse_exited() -> void:
	#_current_state = State.Standart
	#if not _blocked:
		#_player_mood_sprite.frame = State.Standart
#
	#
#func _on_item_container_mouse_entered() -> void:
	#_current_state = State.Tip
	#if not _blocked:
		#_player_mood_sprite.frame = State.Tip
#
#func _on_item_container_mouse_exited() -> void:
	#_current_state = State.Standart
	#if not _blocked:
		#_player_mood_sprite.frame = State.Standart
#
#
#func _on_inventory_container_mouse_entered() -> void:
	#_current_state = State.Tip
	#if not _blocked:
		#_player_mood_sprite.frame = State.Tip
	#
#func _on_inventory_container_mouse_exited() -> void:
	#_current_state = State.Standart
	#if not _blocked:
		#_player_mood_sprite.frame = State.Standart
#
#func _on_hot_bar_updated():
	#_on_hot_bar_slot_changed(_hot_bar.get_current_slot_index())
#
#func _on_hot_bar_slot_changed(slot_index:int):
	#if _current_area_using_item != null:
		#if _current_area_using_item.is_used:
			#_current_state = State.Standart
		#elif  _hot_bar_inventory.items[slot_index] != null &&\
		  #_hot_bar_inventory.items[slot_index].name == _current_area_using_item.item_can_use.name:
			#_current_state = State.CanUse
		#elif _hot_bar_inventory.items[slot_index] != null:
			#_current_state = State.CantUse
		#else:
			#_current_state = State.Tip
		#if not _blocked:
			#_player_mood_sprite.frame = _current_state
#
#func _on_area_using_item_mouse_entered(item:AreaUsingItem) -> void:
	#_current_area_using_item = item
	#var hot_bar_index :int = _hot_bar.get_current_slot_index()
	#if item.is_used:
		#_current_state = State.Standart
	#elif  _hot_bar_inventory.items[ hot_bar_index] != null &&\
		#_hot_bar_inventory.items[hot_bar_index].name == _current_area_using_item.item_can_use.name:
		#_current_state = State.CanUse
	#elif _hot_bar_inventory.items[ hot_bar_index] != null:
		#_current_state = State.CantUse
	#else:
		#_current_state = State.Tip
	#if not _blocked:
		#_player_mood_sprite.frame = _current_state
	#
#func _on_area_using_item_mouse_exited() -> void:
	#_current_area_using_item = null
	#_current_state = State.Standart
	#if not _blocked:
		#_player_mood_sprite.frame = _current_state
#
#func set_player_cant_use_for_time(time_ms:int) -> void:
	#if _blocked:
		#return
	#var temp_state := _current_state
	#_current_state = State.CantUse
	#_blocked = true
	#_player_mood_sprite.frame = _current_state
	#await get_tree().create_timer(time_ms * 1000).timeout
	#_blocked = false
	#_current_state = temp_state
	#_player_mood_sprite.frame = _current_state
#
#func set_player_can_use_for_time(time_ms:int) -> void:
	#if _blocked:
		#return
	#var temp_state := _current_state
	#_current_state = State.CanUse
	#_blocked = true
	#_player_mood_sprite.frame = _current_state
	#await get_tree().create_timer(time_ms * 1000).timeout
	#_blocked = false
	#_current_state = temp_state
	#_player_mood_sprite.frame = _current_state
