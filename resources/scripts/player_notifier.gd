extends Node

@export var ray_cast:RayCast2D
@export var player_detector_area:PlayerDetectorArea

var _deafult_raycast_target_position:Vector2
var _player:Node

var _is_ray_cast_detect:bool

func _ready():
	_deafult_raycast_target_position = ray_cast.target_position
	player_detector_area.player_entered.connect(_on_player_entered_area)
	player_detector_area.player_exited.connect(_on_player_exited_area)
	
func _on_player_entered_area(player) -> void:
	ray_cast.enabled = true
	_player = player
	
func _physics_process(_delta):
	if _player == null:
		return
		
	ray_cast.target_position = ray_cast.to_local(_player.global_position)
	ray_cast.force_raycast_update()
	_is_ray_cast_detect = not _is_obstacle_between_player(_player)
	
func _on_player_exited_area(_player_new) -> void:
	ray_cast.enabled = false
	_is_ray_cast_detect = false
	_player = null
	ray_cast.target_position = _deafult_raycast_target_position

func _is_obstacle_between_player(player:Node) -> bool:
	var body := ray_cast.get_collider()
	return body != player

func is_collide() -> bool:
	return _is_ray_cast_detect

func get_player() -> Node:
	if _is_ray_cast_detect:
		return _player
	return null
