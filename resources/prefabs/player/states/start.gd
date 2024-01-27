extends StateMachineState

func on_enter() -> void:
	await get_tree().physics_frame
	change_state("Idle")
	
