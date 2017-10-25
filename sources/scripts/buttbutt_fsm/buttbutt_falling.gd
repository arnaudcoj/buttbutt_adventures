extends Node

export (NodePath) var fsm_path
var fsm

export (NodePath) var idle_state_path
export (NodePath) var climbing_state_path

export var max_speed = 500
var speed = 100

func _ready():
	fsm = get_node(fsm_path)

func change_state():
	if fsm.body.test_move(fsm.body.transform, Vector2(0,1)):
		fsm.change_state(get_node(idle_state_path))
	elif fsm.is_control_pressed(fsm.Control.Up) and fsm.body.can_climb(): #TODO control jump
		fsm.change_state(get_node(climbing_state_path))

func on_enter():
	fsm.body.current_direction = Vector2(-1,0)
	speed = 100
	pass

func update(delta):
	var direction = Vector2(0,0)
	
	if fsm.is_control_pressed(fsm.Control.Left):
		direction.x -= 1
	elif fsm.is_control_pressed(fsm.Control.RunLeft):
		direction.x -= 1.5
	if fsm.is_control_pressed(fsm.Control.Right):
		direction.x += 1
	elif fsm.is_control_pressed(fsm.Control.RunRight):
		direction.x += 1.5
		
	fsm.body.move_and_slide(direction.normalized() * max_speed)
	
	direction.x = 0
	direction.y = 1
	speed = clamp(speed * 1.1, 0, max_speed)
		
	fsm.body.move_and_slide(direction.normalized() * speed)

func on_leave():
	#print("leave falling")
	pass
