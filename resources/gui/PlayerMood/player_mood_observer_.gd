extends Control

@export var time_bad_mood_ms:int = 1000
@export var player_mood_sprite : Sprite2D

# Mood priorities:
# Can`t use -> highest priority
# Can use
# Tips
# standart nothing

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

