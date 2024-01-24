extends PlayerBaseState
var player_direction:Vector2

func on_enter() -> void:
	player.animation_tree.get("parameters/playback").travel("Walk")
	
	
func on_physics_process(_delta: float) -> void:
	player_direction = player.get_input_vector_normalized()
	player.velocity = player_direction * player.speed
	if player_direction == Vector2.ZERO:
		change_state("Idle")
	else:
		player.animation_tree.set("parameters/Idle/blend_position",player_direction)
		player.animation_tree.set("parameters/Walk/blend_position",player_direction)
