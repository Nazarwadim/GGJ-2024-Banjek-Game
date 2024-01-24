extends Area2D
class_name ItemInteractor
signal item_container_area_entered(inventory:ItemContainer)
signal item_container_area_exited

@export var collision_mask_overide = 2
@export var collision_layer_overide = 2

var entering_item:ItemContainer = null

func _ready():
	collision_mask = collision_mask_overide
	collision_layer = collision_layer_overide
	monitorable = false
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	if area is ItemContainer:
		item_container_area_entered.emit(area)
		entering_item = area

func _on_area_exited(area):
	if area is ItemContainer:
		item_container_area_exited.emit()
		entering_item = null
