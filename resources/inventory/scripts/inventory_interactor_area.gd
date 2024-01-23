extends Area2D
class_name InventoryInteractorArea
signal inventory_container_area_entered(inventory:Inventory)
signal inventory_container_area_exited

func _ready():
	monitorable = false

func _on_area_entered(area):
	if area is InventoryContainerObject:
		inventory_container_area_entered.emit(area.inventory)

func _on_area_exited(area):
	if area is InventoryContainerObject:
		inventory_container_area_exited.emit()
	
