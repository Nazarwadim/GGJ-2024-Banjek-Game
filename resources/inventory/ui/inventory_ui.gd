extends Control
class_name InventoryUI

@export var inventory:Inventory

@onready var back_ground = $BackGround
@onready var grid_items_container :GridContainer= $GridItemsContainer

var _inventory_updater = InventoryUIUpdater.new(self)

func update() -> void:
	_inventory_updater.update()

func open() -> void:
	_inventory_updater.update()
	visible = true

func close() -> void:
	visible = false
