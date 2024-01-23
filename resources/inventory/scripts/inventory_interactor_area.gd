extends Area2D
class_name InventoryInteractor
signal inventory_container_area_entered(inventory:Inventory)
signal inventory_container_area_exited

func _ready():
	monitorable = false
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	if area is InventoryContainer:
		inventory_container_area_entered.emit(area.inventory)

func _on_area_exited(area):
	if area is InventoryContainer:
		inventory_container_area_exited.emit()
