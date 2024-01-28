extends StatePrincipalBase

var areas_to_fix:Array[AreaUsingItem]
@onready var walk_to_point = $"../WalkToPoint"

func on_enter():
	principal.navigation_agent.velocity = Vector2.ZERO
	principal.animation_tree.get("parameters/playback").travel("Angry")
	var area_to_fix = areas_to_fix[0]
	principal.navigation_agent.target_position = area_to_fix.global_position
	walk_to_point.area_to_fix = area_to_fix
	Globals.school_mood = Globals.school_mood + area_to_fix.happiness_increase
	print(area_to_fix.happiness_increase)
	await principal.animation_tree.animation_finished
	change_state("WalkToPoint")
