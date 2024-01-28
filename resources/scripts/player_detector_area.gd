extends Area2D
class_name PlayerDetectorArea

signal player_entered(player)
signal player_exited(player)

func get_first_overlapping_player() -> Player:
	var areas := get_overlapping_bodies()
	if areas.size() == 0:
		return null
	for area in areas:
		if area is Player:
			return area
	return null

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body:Node2D) -> void:
	if body is Player:
		player_entered.emit(body)
	
func _on_body_exited(body:Node2D) -> void:
	if body is Player:
		player_exited.emit(body)
