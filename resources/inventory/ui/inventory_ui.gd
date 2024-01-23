extends Control
@export var inventory:Inventory

@onready var back_ground = $BackGround
@onready var grid_items_container :GridContainer= $GridItemsContainer

var _inventory_updater = preload("res://resources/inventory/ui/inventory_ui_updater.gd").new(self)
func update() -> void:
	_inventory_updater.update()

func open() -> void:
	$AnimationPlayer.play("show")
	visible = true

func close() -> void:
	$AnimationPlayer.play("hide")
	visible = false
