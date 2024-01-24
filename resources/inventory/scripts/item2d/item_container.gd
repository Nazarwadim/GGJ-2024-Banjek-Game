extends Area2D
class_name ItemContainer

signal item_picked

@export var _item:Item

func _ready():
	monitoring = false

func pick_item() -> Item:
	queue_free()
	return _item
