extends Node2D

onready var side_area = $SideArea
onready var raycaster = $RayCaster

func get_ledge_position():
	var bodies = side_area.get_overlapping_bodies()
	if bodies.size() == 0:
		raycaster.force_raycast_update()
		if raycaster.is_colliding():
			return raycaster.get_collision_point()
	
	return null
