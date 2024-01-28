extends StatePrincipalBase

var areas_to_fix:Array[AreaUsingItem]

func on_enter():
	var area_to_fix = areas_to_fix.pop_front()
	principal.navigation_agent.target_position
