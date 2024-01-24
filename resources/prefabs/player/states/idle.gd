extends PlayerBaseState

func on_enter() -> void:
	await get_tree().create_timer(get_process_delta_time()).timeout
	player.animation_tree.get("parameters/playback").travel("Idle")

func on_process(_delta: float) -> void:
	var player_direction :Vector2 = player.get_input_vector_normalized()
	if player_direction != Vector2.ZERO:
		change_state("Walk")
	
	

# Called every physics frame when this state is active.
func on_physics_process(_delta: float) -> void:
	pass


# Called when there is an input event while this state is active.
func on_input(_event: InputEvent) -> void:
	pass

# Called when the state machine exits this state.
func on_exit() -> void:
	pass
