extends Area2D
class_name AreaUsingItem

@export var item_can_use:Item
signal used
var is_used:bool

func _init():
	monitoring = false

func use():
	is_used = true
	used.emit()
	
