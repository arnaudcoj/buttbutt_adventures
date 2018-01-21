extends Node2D

func get_climb_area_center():
	for area in $climb_up_area.get_overlapping_areas():
		if area.has_method("can_climb") && area.can_climb():
			return area.position
	
	for area in $climb_down_area.get_overlapping_areas():
		if area.has_method("can_climb") && area.can_climb():
			return area.position
	
	return null
	

func can_climb():
	return can_climb_up() or can_climb_down()
	
func can_climb_up():
	for area in $climb_up_area.get_overlapping_areas():
		if area.has_method("can_climb") && area.can_climb():
			return true
	
	return false
	
func can_climb_down():
	for area in $climb_down_area.get_overlapping_areas():
		if area.has_method("can_climb") && area.can_climb():
			return true
	
	return false
	