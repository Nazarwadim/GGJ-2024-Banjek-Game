extends CharacterBody2D

@export var MAX_SPEED = 150
@export var target: Node2D

@onready var navigation_agent := $NavigationAgent2D as NavigationAgent2D

func _physics_process(_delta):
	move_and_slide.call_deferred()
	if navigation_agent.is_navigation_finished():
		return	
	var direction = to_local(navigation_agent.get_next_path_position()).normalized()
	var intermediate_velosity :Vector2= direction * MAX_SPEED
	navigation_agent.velocity = intermediate_velosity

func create_path():
	navigation_agent.target_position = target.global_position

func _on_timer_timeout():
	create_path()

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
