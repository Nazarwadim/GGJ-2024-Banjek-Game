extends Control


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

@export var _hot_bar:Control
@onready var _player_mood_sprite = $PlayerMoodSprite
@onready var _hot_bar_inventory:Inventory = _hot_bar.inventory

var _current_area_using_item:AreaUsingItem
var _blocked:bool = false
var _current_state:State

func _ready():
	_hot_bar.current_slot_changed.connect(_on_hot_bar_slot_changed)
	_hot_bar.hot_bar_updated.connect(_on_hot_bar_updated)

func _on_hot_bar_updated():
	_on_hot_bar_slot_changed(_hot_bar.get_current_slot_index())

func _on_hot_bar_slot_changed(slot_index:int):
	if _current_area_using_item != null:
		if _current_area_using_item.is_used:
			_current_state = State.Standart
		elif  _hot_bar_inventory.items[slot_index] != null &&\
		  _hot_bar_inventory.items[slot_index].name == _current_area_using_item.item_can_use.name:
			_current_state = State.CanUse
		elif _hot_bar_inventory.items[slot_index] != null:
			_current_state = State.CantUse
		else:
			_current_state = State.Tip
		if not _blocked:
			_player_mood_sprite.frame = _current_state


func _on_slot_mouse_entered(slot) -> void:
	if slot.item == null:
		return
	_current_state = State.Tip
	if not _blocked:
		_player_mood_sprite.frame = State.Tip

func _on_slot_mouse_exited(_slot) -> void:
	_current_state = State.Standart
	if not _blocked:
		_player_mood_sprite.frame = State.Standart

	
func _on_item_container_mouse_entered(_container) -> void:
	_current_state = State.Tip
	if not _blocked:
		_player_mood_sprite.frame = State.Tip

func _on_item_container_mouse_exited(_container) -> void:
	_current_state = State.Standart
	if not _blocked:
		_player_mood_sprite.frame = State.Standart


func _on_inventory_container_mouse_entered(_container) -> void:
	_current_state = State.Tip
	if not _blocked:
		_player_mood_sprite.frame = State.Tip
	
func _on_inventory_container_mouse_exited(_container) -> void:
	_current_state = State.Standart
	if not _blocked:
		_player_mood_sprite.frame = State.Standart

func _on_area_using_item_mouse_entered(item:AreaUsingItem) -> void:
	_current_area_using_item = item
	var hot_bar_index :int = _hot_bar.get_current_slot_index()
	if item.is_used:
		_current_state = State.Standart
	elif  _hot_bar_inventory.items[ hot_bar_index] != null &&\
		_hot_bar_inventory.items[hot_bar_index].name == _current_area_using_item.item_can_use.name:
		_current_state = State.CanUse
	elif _hot_bar_inventory.items[ hot_bar_index] != null:
		_current_state = State.CantUse
	else:
		_current_state = State.Tip
	if not _blocked:
		_player_mood_sprite.frame = _current_state
	
func _on_area_using_item_mouse_exited(_area_using_item) -> void:
	_current_area_using_item = null
	_current_state = State.Standart
	if not _blocked:
		_player_mood_sprite.frame = _current_state

func set_player_cant_use_for_time(time_ms:int) -> void:
	if _blocked:
		return
	var temp_state := _current_state
	_current_state = State.CantUse
	_blocked = true
	_player_mood_sprite.frame = _current_state
	await get_tree().create_timer(time_ms * 1000).timeout
	_blocked = false
	_current_state = temp_state
	_player_mood_sprite.frame = _current_state

func set_player_can_use_for_time(time_ms:int) -> void:
	if _blocked:
		return
	var temp_state := _current_state
	_current_state = State.CanUse
	_blocked = true
	_player_mood_sprite.frame = _current_state
	await get_tree().create_timer(time_ms * 1000).timeout
	_blocked = false
	_current_state = temp_state
	_player_mood_sprite.frame = _current_state
