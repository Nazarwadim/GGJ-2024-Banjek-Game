extends CharacterBody2D
class_name Player
@export var speed: int = 180
@onready var animation_tree :AnimationTree= $AnimationTree

signal inventory_opened(inventory:Inventory)
signal inventory_closed
signal item_picked
signal item_droped

func get_input_vector_normalized() -> Vector2:
	return Input.get_vector("move_left", "move_right","move_up", "move_down" ).normalized()

func _physics_process(_delta):
	move_and_slide()

func _on_finite_state_machine_state_changed(new_state):
	print(new_state.name)
