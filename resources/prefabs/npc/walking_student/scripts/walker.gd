extends Node
class_name Walker

var _points:Array[Node]

var _current_point_index:int = 0

func _ready() -> void:
	_points = get_children()
	if _points.size() == 0:
		push_error("points in point walker = 0. Add points as childs to walker")
	
func move_to_next_point() -> void:
	if _current_point_index < _points.size() - 1:
		_current_point_index += 1
	else:
		_current_point_index = 0

func get_current_point() -> Node:
	return _points[_current_point_index]
