extends KinematicBody2D

onready var collision = get_node("CollisionShape2D")

export var max_climb_angle = 80
export var max_descend_angle = 80

export var skin_width = 2
var _bottom_left_origin
var _bottom_right_origin
var collision_info = CollisionInfo.new()
onready var space_state = get_world_2d().get_direct_space_state()

func move(var motion):
	update_raycast_origins()
	collision_info.reset()
	
	if motion.x != 0 :
		horizontal_collisions(motion)
	if motion.y != 0:
		vertical_collisions(motion)
	
func horizontal_collisions(motion):
	# we only want horizontal motion here
	motion.y = 0
	
	# modify the motion to follow slope angle if any
	var ray_origin = _bottom_left_origin if motion.x > 0 else _bottom_right_origin
	var hit = space_state.intersect_ray(ray_origin, ray_origin + Vector2(0, 20), [self])
	if not hit.empty():
		motion = descend_slope(hit, motion)
	
	# move the body
	var collision = move_and_collide(motion)
	
	# while there are collisions resolve climbing
	while collision != null:
		collision = climb_slope(collision)

func descend_slope(raycast_hit, motion):
	var direction = Vector2(-raycast_hit.normal.y, raycast_hit.normal.x)
	direction *= sign(motion.x)
	
	# if new direction goes down and collision normal doesn't exceed max descend angle, modify motion
	if direction.y > 0 and abs(raycast_hit.normal.angle_to(Vector2(0,-1))) < deg2rad(max_descend_angle) :
		motion = direction * motion.length()
		collision_info.descending_slope = true
		collision_info.below = true
	
	return motion

func climb_slope(collision):
	var direction = Vector2(-collision.normal.y, collision.normal.x)
	direction *= sign(collision.remainder.x)
	
	if direction.y > 0 or abs(collision.normal.angle_to(Vector2(0,-1))) > deg2rad(max_climb_angle):
		collision_info.left = direction.x < 0
		collision_info.right = direction.x > 0
		return null
		
	var motion = direction * collision.remainder.length()
	
	collision_info.climbing_slope = true
	
	return move_and_collide(motion)
	

func vertical_collisions(motion):
	motion.x = 0
	
	var collision = move_and_collide(motion)
	
	while collision != null:
		if collision.normal.y < 0 and abs(collision.normal.angle_to(Vector2(0,-1))) > deg2rad(max_descend_angle):
			collision = slide_slope(collision)
		else:
			collision_info.below = collision_info.below or collision.normal.y < 0
			collision_info.above = collision_info.above or collision.normal.y > 0
			collision = null
	
func slide_slope(collision):
	var direction = Vector2(-collision.normal.y, collision.normal.x)
	direction *= sign(collision.remainder.y)
	
	var motion = direction * collision.remainder.length()
	return move_and_collide(motion)
	
	
func update_raycast_origins():
	var half_bounds_size = collision.shape.extents - Vector2(skin_width, skin_width)
	_bottom_left_origin = position + Vector2(-half_bounds_size.x, half_bounds_size.y)
	_bottom_right_origin = position + Vector2(half_bounds_size.x, half_bounds_size.y)
	
class CollisionInfo:
	var above = false
	var below = false
	var left = false
	var right = false
	
	var climbing_slope = false
	var descending_slope = false
	
	var slope_angle = 0.0
	var slope_angle_old = 0.0
	
	func reset():
		above = false
		below = false
		left = false
		right = false
		
		climbing_slope = false
		descending_slope = false