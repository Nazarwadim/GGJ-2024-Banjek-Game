extends CharacterBody2D
class_name Principal

@export var speed:int
@onready var navigation_agent = $NavigationAgent2D

func _ready():
	Globals.principal = self

func _exit_tree():
	Globals.principal = null

func _physics_process(_delta):
	move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
