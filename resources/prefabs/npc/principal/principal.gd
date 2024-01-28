extends CharacterBody2D
class_name Principal

signal player_trapped
signal player_chasing


@export var speed:int
@onready var navigation_agent = $NavigationAgent2D
@onready var animation_tree = $AnimationTree


func _ready():
	Globals.principal = self

func _exit_tree():
	Globals.principal = null

func _physics_process(_delta):
	move_and_slide()

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
