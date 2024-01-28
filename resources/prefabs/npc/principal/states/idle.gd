extends StatePrincipalBase

@export var walker :Walker


var _target_point:WalkerPoint

var _is_interrupted:bool = false

func on_enter():
	_is_interrupted = false
	var current_point = walker.get_current_point()
	walker.move_to_next_point()
	_target_point = walker.get_current_point()
	var wait_time = current_point.time_stay_on_ms
	await get_tree().create_timer(wait_time / 1000.0).timeout
	if _is_interrupted:
		return
	principal.navigation_agent.target_position = _target_point.global_position
	change_state("Walk")

