extends Control

@export var _player_mood_sprite : Sprite2D
@export var _hot_bar:Control
@export var _player_inventory:Inventory

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

var _area_using_item_containers:Array[CollisionObject2D] = []
var _chest_containers:Array[CollisionObject2D] = []
var _items:Array[CollisionObject2D] = []

var _blocked := false
var _current_state := State.Standart

func _on_item_ui_mouse_entered() -> void:
	_current_state = State.Tip
	if not _blocked:
		_player_mood_sprite.frame = State.Tip

func _on_item_ui_mouse_exited() -> void:
	_current_state = State.Standart
	if not _blocked:
		_player_mood_sprite.frame = State.Standart

	
func _on_item_container_mouse_entered() -> void:
	_current_state = State.Tip
	if not _blocked:
		_player_mood_sprite.frame = State.Tip

func _on_item_container_mouse_exited() -> void:
	_current_state = State.Standart
	if not _blocked:
		_player_mood_sprite.frame = State.Standart


func _on_inventory_container_mouse_entered() -> void:
	_current_state = State.Tip
	if not _blocked:
		_player_mood_sprite.frame = State.Tip
	
func _on_inventory_container_mouse_exited() -> void:
	_current_state = State.Standart
	if not _blocked:
		_player_mood_sprite.frame = State.Standart


func _on_area_using_item_entered(item) -> void:
	pass
	
func _on_area_using_item_exited(item) -> void:
	pass


func _on_player_cant_use() -> void:
	pass

func _on_player_can_use() -> void:
	pass
