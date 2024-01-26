extends CharacterBody2D
class_name Player
@export var speed: int = 180
@export var items_spawn_node:Node
@export var debug_print_states:bool
@onready var animation_tree :AnimationTree= $AnimationTree
@export var _hot_bar:Control
@onready var gpu_particles_2d = $GPUParticles2D

signal inventory_opened(inventory:Inventory)
signal inventory_closed
signal item_picked
signal item_droped
signal item_start_using(item_time_ms:int)
signal item_using_interrupted(item_name:String)
signal item_used

## Emited when area_using_item_detector detects area_using_item
## and player input "iteract" action but item in hot bar is not the same as area_using_item item
signal can_not_use(why:ErrorCanNotUseItem)
## Emited when player input pick_up, but item_inveractor not detects items
signal can_not_pick_up
## Emited when player try to drop an empty object
signal can_not_drop

enum ErrorCanNotUseItem
{
	EmptyItemInHotBar,
	UnsuitableItem,
	PlayerIsMoving,
}

func get_hot_bar_slot_index() -> int:
	if _hot_bar == null:
		push_error("set hot bar for player to get hot bar slot index")
		return -1
	return _hot_bar.get_current_slot_index()

func get_input_vector_normalized() -> Vector2:
	return Input.get_vector("move_left", "move_right","move_up", "move_down" ).normalized()


func _physics_process(_delta):
	move_and_slide()

func _on_finite_state_machine_state_changed(new_state):
	if debug_print_states:
		print("Time ", Time.get_ticks_msec() ,". State: ", new_state.name)
