extends Control
@export var start_scene : PackedScene 

@export var cant_skip_duration : int = 10
@export var introduction_duration : int = 30

var _can_skip:bool = false
			
func _ready():
	get_tree().create_timer(introduction_duration).timeout.connect(_on_timer_time_out)
	get_tree().create_timer(cant_skip_duration).timeout.connect(_on_cant_skip_timeout)

func _on_cant_skip_timeout() -> void:
	$CanSkipLabel/LabelAnimationPlayer.play("start_showing")
	_can_skip = true

func _on_timer_time_out() -> void:
	get_tree().change_scene_to_packed.call_deferred(start_scene)

func _input(event):
	if event.is_action_pressed("skip") and _can_skip:
		get_tree().change_scene_to_packed.call_deferred(start_scene)
