extends KinematicBody2D

signal dead
signal goal
signal controls

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
	elif area.is_in_group("goal"):
		print("goal")
		emit_signal("goal")
	elif area.is_in_group("controls"):
		print("controls changed : ", area.left_action, area.right_action)
		emit_signal("controls", area.left_action, area.right_action)

func on_pause():
	$HumanControler.reset()