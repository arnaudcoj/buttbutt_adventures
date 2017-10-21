extends Node

export (NodePath) var fsm_path
var fsm

export (NodePath) var idle_state_path
export (NodePath) var falling_state_path
export (NodePath) var climbing_state_path

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
	
	if fsm.is_control_pressed(fsm.Control.Right):
		fsm.body.flip(true)
		direction.x *= -1
		direction.y *= 1
		current_speed = min((current_speed * 1.1), max_speed)
	elif fsm.is_control_pressed(fsm.Control.Left):
		fsm.body.flip(false)
		direction.x *= 1
		direction.y *= -1
		current_speed = min((current_speed * 1.1), max_speed)
	else:
		return
	
	fsm.body.move_and_slide(direction.normalized() * current_speed, Vector2(0,-1))
	
	if fsm.body.get_raycast_point() != null:
		fsm.body.move_and_collide(Vector2(0,fsm.body.get_raycast_point().y - fsm.body.position.y))

func change_state():
	if not fsm.body.on_ground():
		fsm.change_state(get_node(falling_state_path))
	elif fsm.is_control_pressed(fsm.Control.Up) and fsm.body.can_climb(): #TODO Jump
		fsm.change_state(get_node(climbing_state_path))
	elif not fsm.is_control_pressed(fsm.Control.Left) and not fsm.is_control_pressed(fsm.Control.Right):
		fsm.change_state(get_node(idle_state_path))

func on_enter():
	current_speed = 100
	pass
	
func on_leave():
	pass
