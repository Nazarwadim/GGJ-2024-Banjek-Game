extends Control

@export var menu_scene:String
@export var wait_time_to_move_menu:int = 5

func _on_principal_player_trapped():
	visible = true
	await get_tree().create_timer(wait_time_to_move_menu).timeout
	get_tree().change_scene_to_file.call_deferred("res://resources/menu/menu_transition.tscn")
