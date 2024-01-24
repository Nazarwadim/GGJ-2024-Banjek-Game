extends Area2D
class_name ItemContainer

signal item_picked

@export var item:Item
@export var collision_mask_overide = 2
@export var collision_layer_overide = 2

func _ready():
	collision_mask = collision_mask_overide
	collision_layer = collision_layer_overide
	monitoring = false

func pick_item() -> void:
	queue_free()
