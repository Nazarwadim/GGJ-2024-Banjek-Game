extends Control

var cursor1 = load("res://assets/cursor/cursor1.png")
var cursor2 = load("res://assets/cursor/cursor2.png")
# Called when the node enters the scene tree for the first time.

func load_cursor1():
	Input.set_custom_mouse_cursor(cursor1,Input.CURSOR_ARROW, Vector2(18, 5))
	

func load_cursor2():
	Input.set_custom_mouse_cursor(cursor2,Input.CURSOR_ARROW, Vector2(18, 5))
	
func _on_mouse_object_observer_area_using_item_mouse_entered(_area_using_item):
	load_cursor1()

func _on_mouse_object_observer_area_using_item_mouse_exited(_area_using_item):
	load_cursor2()


func _on_mouse_object_observer_inventory_container_mouse_entered(_inventory_container):
	load_cursor1()


func _on_mouse_object_observer_inventory_container_mouse_exited(_inventory_container):
	load_cursor2()


func _on_mouse_object_observer_item_container_mouse_entered(_item_container):
	load_cursor1()


func _on_mouse_object_observer_item_container_mouse_exited(_item_container):
	load_cursor2()


func _on_mouse_object_observer_slot_mouse_entered(_slot):
	load_cursor1()


func _on_mouse_object_observer_slot_mouse_exited(_slot):
	load_cursor2()
