extends Node

export (NodePath) var fsm_path
var fsm

export (NodePath) var idle_state_path
export (NodePath) var jumping_state_path

export var speed = 500

func _ready():
	fsm = get_node(fsm_path)

func change_state():
	if fsm.body.test_move(fsm.body.transform, Vector2(0,1)):
		fsm.change_state(get_node(idle_state_path))
	elif fsm.is_control_pressed(fsm.Control.Up): #TODO control jump
		fsm.change_state(get_node(jumping_state_path))

func on_enter():
	fsm.body.current_direction = Vector2(-1,0)
	pass

func update(delta):
	var direction = Vector2(0,0)
	
	if fsm.is_control_pressed(fsm.Control.Left):
		direction.x -= 1
	if fsm.is_control_pressed(fsm.Control.Right):
		direction.x += 1
		
	fsm.body.move_and_slide(direction.normalized() * speed)
	
	direction.x = 0
	direction.y = 1
		
	fsm.body.move_and_slide(direction.normalized() * speed)

func on_leave():
	#print("leave falling")
	pass
