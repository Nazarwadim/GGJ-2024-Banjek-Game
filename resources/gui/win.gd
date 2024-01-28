extends Control
@export var wait_time_to_move_menu:int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().physics_frame
	SignalBus.global_mood_changed.connect(_on_mood_shanged)

func _on_mood_shanged(value):
	if value > 95:
		visible = true
		await get_tree().create_timer(wait_time_to_move_menu).timeout
		get_tree().change_scene_to_file.call_deferred("res://resources/menu/menu_transition.tscn")
