extends Control

@export var player_mood_sprite : Sprite2D
@export var hot_bar:Control

# Mood priorities:
# Can`t use -> highest priority = 0
# Can use = 1
# Tip = 2
# standart nothing = 3

var _area_using_item_containers:Array[CollisionObject2D] = []
var _chest_containers:Array[CollisionObject2D] = []
var _items:Array[CollisionObject2D] = []

func _on_item_ui_mouse_entered() -> void:
	pass

func _on_item_ui_mouse_exited() -> void:
	pass

	
func _on_item_container_mouse_entered() -> void:
	pass

func _on_item_container_mouse_exited() -> void:
	pass


func _on_inventory_container_mouse_entered() -> void:
	pass
	
func _on_inventory_container_mouse_exited() -> void:
	pass


func _on_area_using_item_entered() -> void:
	pass
	
func _on_area_using_item_exited() -> void:
	pass


func _on_player_cant_use() -> void:
	pass

func _on_player_can_use() -> void:
	pass
