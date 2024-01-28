extends StateMachineState

@export var student:CharacterBody2D

func on_physics_process(_delta):
	if student.navigation_agent.is_navigation_finished():
		change_state("Idle")
		return
	var direction = student.to_local(student.navigation_agent.get_next_path_position()).normalized()
	var intermediate_velosity :Vector2= direction * student.speed
	student.navigation_agent.velocity = intermediate_velosity
