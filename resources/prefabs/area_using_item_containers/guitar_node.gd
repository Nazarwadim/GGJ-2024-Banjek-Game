extends Node2D
class_name GuitarNode

var is_broken: bool = false

func _on_area_using_item_container_used():
	is_broken = true


func _on_timer_timeout():
	is_broken = false
