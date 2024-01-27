extends StateMachineState

func on_enter() -> void:
	get_tree().create_timer(get_process_delta_time()).timeout.connect(func():
		change_state("Idle"))
