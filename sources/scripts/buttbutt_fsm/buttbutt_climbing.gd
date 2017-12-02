extends Node

export (NodePath) var fsm_path
var fsm

export (NodePath) var idle_state_path
export (NodePath) var falling_state_path

export var speed = 500

var reached_top

func _ready():
	fsm = get_node(fsm_path)

func change_state():
	if (fsm.is_control_pressed(fsm.Control.Left) or fsm.is_control_pressed(fsm.Control.Right) or fsm.is_control_pressed(fsm.Control.RunLeft) or fsm.is_control_pressed(fsm.Control.RunRight)) and not fsm.body.can_climb(): #TODO control jump
		fsm.change_state(get_node(falling_state_path))

func on_enter():
	pass

func update(delta):
	var direction = Vector2(0,0)
	
	if fsm.is_control_pressed(fsm.Control.Left):
		direction.x -= 1
	if fsm.is_control_pressed(fsm.Control.Right):
		direction.x += 1
	if fsm.is_control_pressed(fsm.Control.RunLeft):
		direction.x -= 1.5
	if fsm.is_control_pressed(fsm.Control.RunRight):
		direction.x += 1.5
		
	fsm.body.move_and_slide(direction.normalized() * speed)
	
	direction = Vector2()
	
	if fsm.is_control_pressed(fsm.Control.Up) and fsm.body.can_climb_up():
		direction.y -= 1
	if fsm.is_control_pressed(fsm.Control.Down) and fsm.body.can_climb_down():
		direction.y += 1
		
	fsm.body.move_and_collide(direction.normalized() * speed * delta)

func on_leave():
	#print("leave jumping")
	pass
