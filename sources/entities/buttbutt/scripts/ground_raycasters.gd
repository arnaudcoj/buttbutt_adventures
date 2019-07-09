extends Node2D

onready var left_ground_raycaster = $LeftGroundRaycaster
onready var right_ground_raycaster = $RightGroundRaycaster

func get_left_ground_normal() :
	if left_ground_raycaster.get_collider() != null:
		return left_ground_raycaster.get_collision_normal()
	return null

func get_right_ground_normal() :
	if right_ground_raycaster.get_collider() != null:
		return right_ground_raycaster.get_collision_normal()
	return null
	