extends CharacterBody2D
class_name Player
@export var speed: int = 180
@export var items_spawn_node:Node
@export var debug_print_states:bool
@onready var animation_tree :AnimationTree= $AnimationTree
var _hot_bar_slot_index:int = 0
	
signal inventory_opened(inventory:Inventory)
signal inventory_closed
signal item_picked
signal item_droped
signal item_start_using(item_time_ms:int)
signal item_used

func get_hot_bar_slot_index() -> int:
	return _hot_bar_slot_index

func get_input_vector_normalized() -> Vector2:
	return Input.get_vector("move_left", "move_right","move_up", "move_down" ).normalized()

func _physics_process(_delta):
	move_and_slide()

func _on_finite_state_machine_state_changed(new_state):
	if debug_print_states:
		print("Time ", Time.get_ticks_msec() ,". State: ",new_state.name)	

func _on_hot_bar_current_slot_changed(current_slot_index):
	_hot_bar_slot_index = current_slot_index
