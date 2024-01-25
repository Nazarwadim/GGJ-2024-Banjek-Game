extends Area2D
class_name ItemInteractor
signal item_container_area_entered(inventory:ItemContainer)
signal item_container_area_exited

@export var collision_mask_overide = 2
@export var collision_layer_overide = 2

func get_overlapping_item_containers() ->Array:
	var array := Array()
	for area in get_overlapping_areas():
		if area is ItemContainer:
			array.push_back(area)
	return array

func _init():
	monitorable = false

func _ready():
	collision_mask = collision_mask_overide
	collision_layer = collision_layer_overide
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	if area is ItemContainer:
		item_container_area_entered.emit(area)

func _on_area_exited(area):
	if area is ItemContainer:
		item_container_area_exited.emit()
