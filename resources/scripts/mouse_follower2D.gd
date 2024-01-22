extends Node2D
class_name MouseFollower2D

@export var node2d: Node2D

@export var is_working:bool = true:
	set(value):
		is_working = value
		_set_process_mode()

@export var is_lepr:bool
@export var is_look_at:bool
@export var lerp_speed:float

@export var offset:Vector2

func _ready():
	if node2d == null:
		printerr("Node2d is null. Set Node2d")
	_set_process_mode()

func _physics_process(delta):
	var _target_position = get_global_mouse_position()
	if is_lepr:
		node2d.position = _lerp_position(_target_position ,delta)
	else:
		node2d.position = _target_position + offset
	if is_look_at && node2d.position != _target_position:
		node2d.look_at(_target_position)
	
func _lerp_position(target_position, delta) -> Vector2:
	var blend : float =  1 - pow(0.5, delta * lerp_speed)
	return node2d.position.lerp(target_position + offset, blend)

func _set_process_mode() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT if is_working else Node.PROCESS_MODE_DISABLED
