extends StatePrincipalBase

@export var area_using_item_detector:AreaUsingItemDetector
@onready var fixing_broken_area_using_item = $"../FixingBrokenAreaUsingItem"
@onready var area_using_item_detector_to_fix = $"../../Areas/AreaUsingItemDetectorToFix"

@export var player_notifier:PlayerNotifier
var area_to_fix:AreaUsingItem

var _player_direction:Vector2

func on_enter():
	area_using_item_detector.area_using_item_entered.connect(_on_area_using_item_detector_area_using_item_entered)
	principal.animation_tree.get("parameters/playback").travel("WalkToPoint")
	
func on_physics_process(_delta:float) -> void:
	_player_direction = principal.velocity.normalized()
	_set_animation_tree_blend_position()
	if player_notifier.is_collide():
		change_state("ChasePlayer")
	if area_using_item_detector_to_fix.get_first_overlapping_area_using_item() == area_to_fix:
		if area_to_fix != null:
			fix_area_using_item_and_set_null()
			change_state("Idle")
			return
	if principal.navigation_agent.is_navigation_finished():
		change_state("Idle")
		return
	var direction = principal.to_local(principal.navigation_agent.get_next_path_position()).normalized()
	var intermediate_velosity :Vector2= direction * principal.speed
	principal.navigation_agent.velocity = intermediate_velosity

func fix_area_using_item_and_set_null() -> void:
	area_to_fix.fix()
	fixing_broken_area_using_item.areas_to_fix.pop_back()
	area_to_fix = null

func _on_area_using_item_detector_area_using_item_entered(area:AreaUsingItem):
	if area.is_used:
		fixing_broken_area_using_item.areas_to_fix.push_back(area)
		change_state("FixingBrokenAreaUsingItem")

func _set_animation_tree_blend_position() -> void:
	principal.animation_tree.set("parameters/Idle/blend_position", _player_direction)
	principal.animation_tree.set("parameters/WalkToPoint/blend_position", _player_direction)

func on_exit():
	area_using_item_detector.area_using_item_entered.disconnect(_on_area_using_item_detector_area_using_item_entered)
