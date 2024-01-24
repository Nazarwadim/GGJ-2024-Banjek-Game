extends CharacterBody2D

signal inventory_opened(inventory:Inventory)
signal inventory_closed
signal item_picked
signal item_droped

##TODO change this to normal movement
const SPEED = 300.0
func _physics_process(_delta):
	var direction := Input.get_vector("ui_left", "ui_right","ui_down", "ui_up" ).normalized()
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	move_and_slide()

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

func _on_item_entered(item_container:ItemContainer):
	var first_free_cell :int= $InventoryContainerObject.inventory.find_first_free_cell()
	if first_free_cell >= 0:
		$InventoryContainerObject.inventory.items[first_free_cell] = item_container.item
		item_container.pick_item()
		item_picked.emit()
