extends KinematicBody2D

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

func get_raycast_point():
	if $raycast.is_colliding():
		return $raycast.get_collision_point()
	return null

func get_collision_normal():
	if $raycast.is_colliding():
		return $raycast.get_collision_normal()
	return null
	
func move_and_slide(linear_velocity, floor_normal=Vector2( 0, -1 ), slope_stop_min_velocity=5, max_bounces=4, floor_max_angle=0.785398 ):
	return .move_and_slide(linear_velocity, floor_normal, slope_stop_min_velocity, max_bounces, floor_max_angle)
	
func enable_rectangular_collision():
	$rectangular_collision.disabled = false
	$capsule_collision.disabled = true
	
func enable_capsule_collision():
	$rectangular_collision.disabled = true
	$capsule_collision.disabled = false