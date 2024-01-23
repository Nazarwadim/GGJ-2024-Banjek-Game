extends CharacterBody2D

@export var speed: int = 180

func _physics_process(_delta):
	var direction := _get_direction_normalized()
	if direction != Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Idle/blend_position",direction)
		$AnimationTree.set("parameters/Walk/blend_position",direction)
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		$AnimationTree.get("parameters/playback").travel("Idle")
	
	move_and_slide()

func _get_direction_normalized() -> Vector2:
	var direction:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1
	return direction.normalized()
