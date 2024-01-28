extends StatePrincipalBase

@export var walker :Walker
@export var area_using_item_detector:AreaUsingItemDetector

@onready var fixing_broken_area_using_item = $"../FixingBrokenAreaUsingItem"
@onready var player_notifier :PlayerNotifier= $"../../PlayerNotifier"

var _target_point:WalkerPoint

var _is_interrupted:bool = false

func on_enter():
	principal.navigation_agent.velocity = Vector2.ZERO
	area_using_item_detector.area_using_item_entered.connect(_on_area_using_item_detector_area_using_item_entered)
	
	if fixing_broken_area_using_item.areas_to_fix.size() > 0:
		change_state("FixingBrokenAreaUsingItem")
		return
	_is_interrupted = false
	var current_point = walker.get_current_point()
	walker.move_to_next_point()
	_target_point = walker.get_current_point()
	var wait_time = current_point.time_stay_on_ms
	principal.animation_tree.get("parameters/playback").travel("Idle")
	await get_tree().create_timer(wait_time / 1000.0).timeout
	if _is_interrupted:
		return
	principal.navigation_agent.target_position = _target_point.global_position
	change_state("WalkToPoint")

func _on_area_using_item_detector_area_using_item_entered(area:AreaUsingItem):
	if area.is_used:
		_is_interrupted = true
		fixing_broken_area_using_item.areas_to_fix.push_back(area)
		change_state("FixingBrokenAreaUsingItem")

func on_physics_process(_delta) -> void:
	if player_notifier.is_collide():
		change_state("ChasePlayer")

func on_exit():
	area_using_item_detector.area_using_item_entered.disconnect(_on_area_using_item_detector_area_using_item_entered)
