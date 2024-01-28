extends StatePrincipalBase

@export var player_notifier:PlayerNotifier
@onready var player_dead_area = $"../../Areas/PlayerDead"
@onready var update_position_timer = $UpdatePositionTimer
@onready var player_detector_area :PlayerDetectorArea= $"../../Areas/PlayerDetectorArea"

@export var speed_increase:float = 5

var _player_direction:Vector2

func _ready():
	update_position_timer.timeout.connect(_on_update_position_timer_timeout)

func on_enter():
	player_dead_area.body_entered.connect(_on_body_entered)
	update_position_timer.start()
	principal.navigation_agent.velocity = Vector2.ZERO

func on_physics_process(_delta):
	_player_direction = principal.velocity.normalized()
	_set_animation_tree_blend_position()
	var player := player_detector_area.get_first_overlapping_player()
	if player == null:
		change_state("Idle")	
		return
	var direction = principal.to_local(principal.navigation_agent.get_next_path_position()).normalized()
	var intermediate_velosity :Vector2= direction * (principal.speed + speed_increase)
	principal.navigation_agent.velocity = intermediate_velosity

func _set_animation_tree_blend_position() -> void:
	principal.animation_tree.set("parameters/Idle/blend_position", _player_direction)
	principal.animation_tree.set("parameters/WalkToPoint/blend_position", _player_direction)
	
func _on_update_position_timer_timeout():
	var player := player_notifier.get_player()
	if player == null:
		return
	principal.navigation_agent.target_position = player.global_position

func _on_body_entered(body):
	if body is Player:
		principal.player_trapped.emit()

func on_exit():
	player_dead_area.body_entered.disconnect(_on_body_entered)
	update_position_timer.stop()
