extends Area2D
class_name InventoryContainer

signal inventory_opened
signal inventory_closed

@export var inventory:Inventory

func _ready():
	monitoring = false
