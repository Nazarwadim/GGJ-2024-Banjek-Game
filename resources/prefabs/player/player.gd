extends CharacterBody2D

signal inventory_opened(inventory:Inventory)
signal inventory_closed
	
##TODO change this to normal movement
const SPEED = 300.0
func _physics_process(_delta):
	var direction := _get_direction()
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _get_direction() -> Vector2:
	var direction:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	elif Input.is_action_pressed("ui_down"):
		direction.y = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	elif Input.is_action_pressed("ui_right"):
		direction.x = 1
	return direction

func _on_hot_bar_current_slot_changed(_current_slot_index):
	#TODO example in this we should create using item fabric item and add etc.
	var item_marker :Marker2D=  $ItemPosition
	if item_marker.get_child_count() != 0:
		item_marker.get_child(0).queue_free()

##TODO make it in state interact_inventory
func _on_inventory_container_area_entered(inventory:InventoryContainer):
	inventory_opened.emit(inventory.inventory)
##TODO make it in state interact_inventory	
func _on_inventory_container_area_exited():
	inventory_closed.emit()
