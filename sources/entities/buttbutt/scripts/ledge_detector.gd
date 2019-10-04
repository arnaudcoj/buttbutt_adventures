extends Node2D

onready var side_area = $SideArea
onready var raycaster = $RayCaster

var enabled = true

func _input(event):
	if event.is_action_pressed("debug_toggle_platform_helpers"):
		enabled = !enabled
		if enabled:
			print("enable ledge detection")
		else:
			print("disable ledge detection")
			

func get_ledge_position():
	if can_grab_ledge():
		return raycaster.get_collision_point()
	return null

func can_grab_ledge():
	if not enabled:
		return false
	var bodies = side_area.get_overlapping_bodies()
	if bodies.size() == 0:
		raycaster.force_raycast_update()
		return raycaster.is_colliding()
	return false