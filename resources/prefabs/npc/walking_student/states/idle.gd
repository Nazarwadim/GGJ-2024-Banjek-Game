extends StateMachineState

@export var walker :Walker
@export var student:CharacterBody2D

var _target_point:WalkerPoint

func on_enter():
	var current_point = walker.get_current_point() as WalkerPoint
	walker.move_to_next_point()
	_target_point = walker.get_current_point()
	var wait_time = current_point.time_stay_on_ms
	await get_tree().create_timer(wait_time / 1000.0).timeout
	student.navigation_agent.target_position = _target_point.global_position
	change_state("Walk")
