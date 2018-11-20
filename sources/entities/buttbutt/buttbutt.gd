extends KinematicBody2D

signal dead

func get_left_ground_normal() :
	if $LeftGroundRaycast.get_collider() != null:
		return $LeftGroundRaycast.get_collision_normal()
	return null

func get_right_ground_normal() :
	if $RightGroundRaycast.get_collider() != null:
		return $RightGroundRaycast.get_collision_normal()
	return null
	
func _on_area_entered(area):
	emit_signal("dead")
	#DEBUG
	get_tree().reload_current_scene()
