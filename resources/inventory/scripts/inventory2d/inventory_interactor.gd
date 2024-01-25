extends Area2D
class_name InventoryInteractor
signal inventory_container_area_entered(inventory:InventoryContainer)
signal inventory_container_area_exited

func get_first_overlapping_inventory_container() -> InventoryContainer:
	var areas := get_overlapping_areas()
	if areas.size() == 0:
		return null
	for area in areas:
		if area is InventoryContainer:
			return area
	return null

func _init():
	monitorable = false

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area):
	if area is InventoryContainer:
		inventory_container_area_entered.emit(area)

func _on_area_exited(area):
	if area is InventoryContainer:
		inventory_container_area_exited.emit()
