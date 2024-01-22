extends CharacterBody2D
const SPEED = 300.0

@export var inventory:Inventory

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up",  "ui_down")
	if direction:
		velocity = direction * SPEED
	move_and_slide()

func _on_hot_bar_current_slot_changed(current_slot_index):
	#TODO example in this we should create using item fabric item and add etc.
	var item_marker :Marker2D=  $ItemPosition
	if item_marker.get_child_count() != 0:
		item_marker.get_child(0).queue_free()
