extends Control
@export var inventory:Inventory

@onready var back_ground = $BackGround
@onready var grid_items_container :GridContainer= $GridItemsContainer

var _inventory_updater = preload("res://resources/inventory/ui/inventory_ui_updater.gd").new(self)
func update() -> void:
	assert(inventory != null, "Inventory is null, can`t update inventory. Set inventory before update it")
	_inventory_updater.update()

func open() -> void:
	$AnimationPlayer.play("show")

func close() -> void:
	$AnimationPlayer.play("hide")
