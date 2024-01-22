extends CharacterBody2D
const SPEED = 300.0

@export var inventory:Inventory

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up",  "ui_down")
	if direction:
		velocity = direction * SPEED
	move_and_slide()
