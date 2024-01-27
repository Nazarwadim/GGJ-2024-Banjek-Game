extends CharacterBody2D

@export var speed:int = 100
@onready var navigation_agent :NavigationAgent2D= $NavigationAgent2D

func _physics_process(_delta):
	move_and_slide()
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
