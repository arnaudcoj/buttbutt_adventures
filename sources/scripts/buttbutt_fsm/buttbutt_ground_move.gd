extends Node

export (NodePath) var fsm_path
var fsm

export (NodePath) var slide_state_path
export (NodePath) var falling_state_path
export (NodePath) var climbing_state_path
export (NodePath) var jumping_state_path

export var max_speed = 500
var current_speed = 100

func _ready():
	fsm = get_node(fsm_path)

func update(delta):
	fsm.body.current_direction.y = max(0, fsm.body.current_direction.y)

	if fsm.body.get_collision_normal() != null:
		fsm.body.current_direction.x = fsm.body.get_collision_normal().y
		fsm.body.current_direction.y = fsm.body.get_collision_normal().x

	var direction = fsm.body.current_direction

	if is_moving_right():
		fsm.body.flip(true)
		direction.x *= -1
		direction.y *= 1
		current_speed = min((current_speed * 1.1), max_speed)
	elif is_moving_left():
		fsm.body.flip(false)
		direction.x *= 1
		direction.y *= -1
		current_speed = min((current_speed * 1.1), max_speed)
	else:
		return

	fsm.body.move_and_slide(direction.normalized() * current_speed)

	if fsm.body.get_raycast_point() != null:
		fsm.body.move_and_collide(Vector2(0,fsm.body.get_raycast_point().y - fsm.body.position.y))

func on_enter():
	current_speed = 100
	pass

func on_leave():
	pass
