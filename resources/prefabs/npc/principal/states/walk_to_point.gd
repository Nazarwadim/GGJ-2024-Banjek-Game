extends StatePrincipalBase

var area_to_fix:AreaUsingItem

func on_physics_process(_delta:float) -> void:
	if principal.navigation_agent.is_navigation_finished():
		if area_to_fix == null:
			change_state("Idle")
		else :
			change_state("FixingBrokenAreaUsingItem")
		return
	var direction = principal.to_local(principal.navigation_agent.get_next_path_position()).normalized()
	var intermediate_velosity :Vector2= direction * principal.speed
	principal.navigation_agent.velocity = intermediate_velosity

func fix_area_using_item() -> void:
	area_to_fix.fix()
