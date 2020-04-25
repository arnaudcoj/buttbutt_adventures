extends KinematicBody2D

class_name ButtButt

export var horizontal_speed := 500
export var horizontal_start_speed := 50
export var horizontal_max_time := .2
export var horizontal_stop_time := .3
export var horizontal_stop_time_fall := .6
export var jump_height := 300
export var jump_apex_time := .5
export var ghost_jump_time := .4
export var jump_input_time := .15
export var can_grab_ledge := true
export var step_fix_height := 30
export var snap_vector := Vector2(0, 32)
export var floor_max_angle := deg2rad(50)

const up_vector = Vector2.UP

onready var gravity = 2 * jump_height / pow(jump_apex_time, 2)
onready var acceleration_factor = (horizontal_speed - horizontal_start_speed) / horizontal_max_time
onready var deceleration_factor = horizontal_speed / horizontal_stop_time
onready var deceleration_factor_fall = horizontal_speed / horizontal_stop_time_fall

signal dead
signal goal
signal controls

var velocity := Vector2()

export (NodePath) var controler_path
onready var controler = get_node(controler_path)

onready var skeleton = $Skeleton
onready var ground_raycasters = $GroundRaycasters
onready var ledge_detectors = $LedgeDetectors

func _ready():
	print(skeleton)
	connect("controls", controler, "update_controls")

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

func can_grab_left_ledge():
	if is_on_wall():
		return ledge_detectors.left_ledge_detector.can_grab_ledge()
	return false

func can_grab_right_ledge():
	if is_on_wall():
		return ledge_detectors.right_ledge_detector.can_grab_ledge()
	return false

func fix_step_height():
	if !is_on_wall():
		return false
		
	var space_state := get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var collision_shape := $FullCollision
	var collision_shape_extents : Vector2 = $FullCollision.shape.extents
	
	var from = Vector2(collision_shape.global_position.x + sign(velocity.x) * (collision_shape_extents.x + 1 ), collision_shape.global_position.y - collision_shape_extents.y)
	var to = Vector2(collision_shape.global_position.x + sign(velocity.x) * (collision_shape_extents.x + 1), collision_shape.global_position.y + collision_shape_extents.y)
	
	var inside_shape = space_state.intersect_point(from)
	
	if !inside_shape:
		var result = space_state.intersect_ray(from, to, [self], collision_mask)
		print(result)
		if result and (to - result.position).y < step_fix_height:
			position.y = result.position.y - 2
			return true
	
	return false
	
func is_normal_wall(normal, ground_normal = Vector2.UP):
#	print(abs(ground_normal.angle_to(normal)), " > ", floor_max_angle)
	return abs(ground_normal.angle_to(normal)) > floor_max_angle

func is_normal_floor(normal, ground_normal = Vector2.UP):
#	print(abs(ground_normal.angle_to(normal)), " < ", floor_max_angle)
	return abs(ground_normal.angle_to(normal)) < floor_max_angle
	
func on_pause():
	controler.reset()
	
func _enter_tree():
	skeleton = $Skeleton
