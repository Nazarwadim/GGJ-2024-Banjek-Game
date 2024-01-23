extends Area2D
class_name InventoryInteractor
signal inventory_container_area_entered(inventory:InventoryContainer)
signal inventory_container_area_exited

func _ready():
	monitorable = false
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	if area is InventoryContainer:
		inventory_container_area_entered.emit(area)

func _on_area_exited(area):
	if area is InventoryContainer:
		inventory_container_area_exited.emit()
