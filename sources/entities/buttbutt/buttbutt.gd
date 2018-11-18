extends KinematicBody2D

func get_left_ground_normal() :
	if $LeftGroundRaycast.get_collider() != null:
		return $LeftGroundRaycast.get_collision_normal()
	return null

func get_right_ground_normal() :
	if $RightGroundRaycast.get_collider() != null:
		return $RightGroundRaycast.get_collision_normal()
	return null