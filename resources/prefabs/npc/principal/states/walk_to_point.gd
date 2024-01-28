extends StatePrincipalBase

func on_physics_process(_delta:float) -> void:
	if principal.navigation_agent.is_navigation_finished():
		change_state("Idle")
		return
	var direction = principal.to_local(principal.navigation_agent.get_next_path_position()).normalized()
	var intermediate_velosity :Vector2= direction * principal.speed
	principal.navigation_agent.velocity = intermediate_velosity
