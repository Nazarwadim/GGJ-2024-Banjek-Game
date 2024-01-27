extends CharacterBody2D

@export var speed:int = 100
@onready var navigation_agent :NavigationAgent2D= $NavigationAgent2D
@onready var animation_player = $AnimationPlayer

func _ready():
	SignalBus.global_mood_changed.connect(_on_global_mood_changed)

func _physics_process(_delta):
	move_and_slide()

func _on_global_mood_changed(value):
	var mood_level = (5*value) / 100
	mood_level = clampi(mood_level, 0, 4)
	var animation_name = "idle_mood_" + str(mood_level)
	animation_player.play(animation_name)
	
func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
