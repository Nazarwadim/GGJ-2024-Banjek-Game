extends Area2D
class_name AreaUsingItemDetector
signal area_using_item_entered(area:Area2D)
signal area_using_item_exited

func get_first_overlapping_area_using_item() -> AreaUsingItem:
	var areas := get_overlapping_areas()
	if areas.size() == 0:
		return null
	for area in areas:
		if area is AreaUsingItem:
			return area
	return null

func _init():
	monitorable = false

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	
func _on_area_entered(area:Area2D) -> void:
	if area is AreaUsingItem:
		area_using_item_entered.emit(area)
	
func _on_area_exited(area:Area2D) -> void:
	if area is AreaUsingItem:
		area_using_item_exited.emit()
