extends Node

export (NodePath) var fsm_path
var fsm

export (NodePath) var slide_state_path
export (NodePath) var falling_state_path
export (NodePath) var climbing_state_path
export (NodePath) var jumping_state_path

export var max_speed = 500

var current_tangeant = Vector2(-1,0)

func _ready():
	fsm = get_node(fsm_path)

func update(delta):
	var target_direction = Vector2()

	if fsm.body.get_collision_normal() != null:
		current_tangeant.x = fsm.body.get_collision_normal().y
		current_tangeant.y = fsm.body.get_collision_normal().x

	if is_moving_right():
		fsm.body.flip(true)
		target_direction.x = -1 * current_tangeant.x
		target_direction.y = 1 * current_tangeant.y
	elif is_moving_left():
		fsm.body.flip(false)
		target_direction.x = 1 * current_tangeant.x
		target_direction.y = -1 * current_tangeant.y
	else:
		return
		
	var target_speed = target_direction * max_speed
	target_speed.x = lerp(fsm.current_speed.x, target_speed.x, .1)
	target_speed.y = lerp(fsm.current_speed.y, target_speed.y, .1)
	
	fsm.body.move_and_slide(target_speed)

	if fsm.body.get_raycast_point() != null:
		fsm.body.move_and_collide(Vector2(0,fsm.body.get_raycast_point().y - fsm.body.position.y))

func on_enter():
	current_tangeant = Vector2(-1,0)
	
func on_leave():
	pass
