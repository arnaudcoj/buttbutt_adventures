extends Node

export (NodePath) var fsm_path
var fsm

export (NodePath) var idle_state_path
export (NodePath) var falling_state_path

export var speed = 500

func _ready():
	fsm = get_node(fsm_path)

func change_state():
	if not fsm.is_control_pressed(fsm.Control.Jump) or $jump_time.is_stopped(): #TODO control jump
		fsm.change_state(get_node(falling_state_path))
	elif fsm.body.on_ground():
		fsm.change_state(get_node(idle_state_path))

func on_enter():
	#print("enter jumping")
	$jump_time.start()
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
		
	fsm.body.move_and_slide(direction.normalized() * speed)
	
	if fsm.is_control_pressed(fsm.Control.Jump):
		direction.x = 0
		direction.y = -1.5
		fsm.body.move_and_slide(direction.normalized() * speed)

func on_leave():
	#print("leave jumping")
	pass
