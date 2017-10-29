extends KinematicBody2D

var current_direction = Vector2(-1,0)
var current_speed = Vector2(0,0)

func _ready():
	pass

func flip(to_the_right):
	if to_the_right:
		$buttbutt_skeleton.scale.x = -abs($buttbutt_skeleton.scale.x)
	else:
		$buttbutt_skeleton.scale.x = abs($buttbutt_skeleton.scale.x)

func on_ground():
	return test_move(transform, Vector2(0,10))
	
func can_climb():
	for area in $interaction_area.get_overlapping_areas():
		if area.has_method("can_climb") && area.can_climb():
			return true
	return false

func get_raycast_point():
	if $raycast.is_colliding():
		return $raycast.get_collision_point()
	return null

func get_collision_normal():
	if $raycast.is_colliding():
		return $raycast.get_collision_normal()
	return null
	
func move_and_slide(linear_velocity, floor_normal=Vector2( 0, -1 ), slope_stop_min_velocity=5, max_bounces=4, floor_max_angle=0.785398 ):
	current_speed = linear_velocity
	return .move_and_slide(linear_velocity, floor_normal, slope_stop_min_velocity, max_bounces, floor_max_angle)