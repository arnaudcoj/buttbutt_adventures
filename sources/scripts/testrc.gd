extends KinematicBody2D

onready var collision = get_node("CollisionShape2D")

export var skin_width = 10 # a bit too high in my opinion but otherwise raycast doesn't work
export var horizontal_ray_count = 4
export var vertical_ray_count = 4

var max_climb_angle = 80

var _horizontal_ray_spacing
var _vertical_ray_spacing

var _top_left_origin
var _top_right_origin
var _bottom_left_origin
var _bottom_right_origin

var collision_info = CollisionInfo.new()
onready var rc = get_node("RayCast2D")

func _ready():
	compute_ray_spacing()
	
func move(var motion):
	update_raycast_origins()
	collision_info.reset()
	
	if motion.x != 0:
		motion = horizontal_collisions(motion)
	if motion.y != 0:
		motion = vertical_collisions(motion)
	
	move_and_collide(motion)
	
func horizontal_collisions(motion):
	var space_state = get_world_2d().get_direct_space_state()
	var direction_x = sign(motion.x)
	var ray_length = abs(motion.x) + skin_width
	
	var i = 0
	
	rc.global_position = _bottom_left_origin if direction_x < 0 else _bottom_right_origin
	
	while i < horizontal_ray_count:
		var ray_origin = _bottom_left_origin if direction_x < 0 else _bottom_right_origin
		ray_origin += Vector2(0,-1) * _horizontal_ray_spacing * i
		
		var hit = space_state.intersect_ray(ray_origin, ray_origin + Vector2(ray_length * direction_x, 0), [self])
		
		if not hit.empty():
			var hit_distance = (hit.position - ray_origin).length()
			var slope_angle = abs(hit.normal.angle_to(Vector2(0,-1)))
			
			if i == 0 and abs(slope_angle) < abs(deg2rad(max_climb_angle)):
				var distance_to_slope_start = 0.0
				
				if slope_angle != collision_info.slope_angle_old:
					distance_to_slope_start = hit_distance - skin_width
					motion.x -= distance_to_slope_start * direction_x
				
				motion = climb_slope(motion, slope_angle)
				motion.x += distance_to_slope_start * direction_x
			
			if not collision_info.climbing_slope or abs(slope_angle) > abs(deg2rad(max_climb_angle)):
				motion.x = (hit_distance - skin_width) * direction_x
				ray_length = hit_distance
			
				if collision_info.climbing_slope:
					motion.y = - tan (collision_info.slope_angle) * abs(motion.x) # -tan because y inverted
			
				collision_info.left = direction_x < 0
				collision_info.right = direction_x > 0

		i += 1
	
	return motion
	
func vertical_collisions(motion):
	var space_state = get_world_2d().get_direct_space_state()
	var direction_y = sign(motion.y)
	var ray_length = abs(motion.y) + skin_width
	
	var i = 0
	while i < vertical_ray_count:
		var ray_origin = _top_left_origin if direction_y < 0 else _bottom_left_origin
		ray_origin += Vector2(1,0) * _vertical_ray_spacing * i
		
		var hit = space_state.intersect_ray(ray_origin, ray_origin + Vector2(0, ray_length * direction_y), [self])
		
		if not hit.empty():
			var hit_distance = (hit.position - ray_origin).length()
			motion.y = (hit_distance - skin_width) * direction_y
			ray_length = hit_distance
			
			if collision_info.climbing_slope:
				motion.x = motion.y / tan(collision_info.slope_angle) * sign(motion.x)
			
			collision_info.above = direction_y < 0
			collision_info.below = direction_y > 0
		
		i += 1
	
	if collision_info.climbing_slope:
		var direction_x = sign(motion.x)
		ray_length = abs(motion.x) + skin_width
		var ray_origin = (_bottom_left_origin if direction_x < 0 else _bottom_right_origin) + Vector2(0,motion.y)
		print(motion.y)
		var hit = space_state.intersect_ray(ray_origin, ray_origin + Vector2(ray_length * direction_x, 0), [self])
		
		if not hit.empty():
			var hit_distance = (hit.position - ray_origin).length()
			var slope_angle = hit.normal.angle_to(Vector2(0,-1))
			if slope_angle != collision_info.slope_angle:
				motion.x = (hit_distance - skin_width) * direction_x
				collision_info.slope_angle = slope_angle
	
	return motion
	
func climb_slope(motion, slope_angle):
	var move_distance = abs(motion.x)
	var climb_motion_y = -sin(slope_angle) * move_distance # -sin because y inverted
	
	if motion.y > climb_motion_y: #> instead of <= because inverted
		motion.y = climb_motion_y
		motion.x = cos(slope_angle) * move_distance * sign(motion.x)
		collision_info.below = true
		collision_info.climbing_slope = true
		collision_info.slope_angle = slope_angle
	
	return motion
	
func compute_ray_spacing():
	horizontal_ray_count = max(horizontal_ray_count, 2)
	vertical_ray_count = max(vertical_ray_count, 2)
	
	var half_bounds_size = collision.shape.extents - Vector2(skin_width, skin_width)
	
	_horizontal_ray_spacing = half_bounds_size.y * 2 / (horizontal_ray_count - 1)
	_vertical_ray_spacing = half_bounds_size.x * 2 / (vertical_ray_count - 1)

func update_raycast_origins():
	var half_bounds_size = collision.shape.extents - Vector2(skin_width, skin_width)
	_bottom_left_origin = position + Vector2(-half_bounds_size.x, half_bounds_size.y)
	_bottom_right_origin = position + Vector2(half_bounds_size.x, half_bounds_size.y)
	_top_left_origin = position + Vector2(-half_bounds_size.x, -half_bounds_size.y)
	_top_right_origin = position + Vector2(half_bounds_size.x, -half_bounds_size.y)
	
class CollisionInfo:
	var above = false
	var below = false
	var left = false
	var right = false
	
	var climbing_slope = false
	
	var slope_angle = 0.0
	var slope_angle_old = 0.0
	
	func reset():
		above = false
		below = false
		left = false
		right = false
		
		climbing_slope = false
		slope_angle_old = slope_angle
		slope_angle = 0.0