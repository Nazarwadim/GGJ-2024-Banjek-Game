extends StatePrincipalBase

@export var walker :Walker
@export var area_using_item_detector:AreaUsingItemDetector

@onready var fixing_broken_area_using_item = $"../FixingBrokenAreaUsingItem"

var _target_point:WalkerPoint

var _is_interrupted:bool = false

func on_enter():
	if fixing_broken_area_using_item.areas_to_fix.size() > 0:
		change_state("FixingBrokenAreaUsingItem")
	
	_is_interrupted = false
	var current_point = walker.get_current_point()
	walker.move_to_next_point()
	_target_point = walker.get_current_point()
	var wait_time = current_point.time_stay_on_ms
	await get_tree().create_timer(wait_time / 1000.0).timeout
	if _is_interrupted:
		return
	principal.navigation_agent.target_position = _target_point.global_position
	change_state("Walk")

func _on_area_using_item_detector_area_using_item_entered(area:AreaUsingItem):
	if area.is_used:
		_is_interrupted = true
		principal.animation_player.play("angry")
		fixing_broken_area_using_item.areas_to_fix.push_back(area)
		change_state("FixingBrokenAreaUsingItem")
