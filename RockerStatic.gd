extends AnimatableBody2D

@export var guitar: GuitarNode
@onready var music1:AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var music2:AudioStreamPlayer2D = $AudioStreamPlayer2D2

# Called when the node enters the scene tree for the first time.
func _ready():
	music1.play()


func _on_area_using_item_container_used():
	if guitar.is_broken == true:
		music1.stream_paused = true
		music2.play()


func _on_timer_timeout():
	guitar.is_broken = false
	music2.stream_paused = true
	music1.play()
