extends Node

export (NodePath) var fsm_path
var fsm

export (NodePath) var idle_state_path

export var speed = 500

func _ready():
	fsm = get_node(fsm_path)

func change_state():
	if fsm.on_ground():
		fsm.change_state(get_node(idle_state_path))

func on_enter():
	print("enter falling")

func update(delta):
	var direction = Vector2(0,0)
	
	if Input.is_action_pressed("ui_left"):
		direction.x -= .3
	if Input.is_action_pressed("ui_right"):
		direction.x += .3
		
	direction.y = 1
		
	fsm.body.move_and_slide(direction.normalized() * speed)

func on_leave():
	print("leave falling")
