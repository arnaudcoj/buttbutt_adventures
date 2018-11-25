extends KinematicBody2D

signal dead
signal goal

var velocity := Vector2()

func get_left_ground_normal() :
	if $LeftGroundRaycast.get_collider() != null:
		return $LeftGroundRaycast.get_collision_normal()
	return null

func get_right_ground_normal() :
	if $RightGroundRaycast.get_collider() != null:
		return $RightGroundRaycast.get_collision_normal()
	return null
	
func _on_area_entered(area : Area2D):
	if area.is_in_group("death"):
		print("dead")
		emit_signal("dead")
		#DEBUG
		get_tree().reload_current_scene()
	elif area.is_in_group("goal"):
		print("goal")
		emit_signal("goal")
		#DEBUG
		get_tree().reload_current_scene()
