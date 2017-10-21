extends Node

export (NodePath) var fsm_path
var fsm

export (NodePath) var idle_state_path
export (NodePath) var falling_state_path

export var speed = 500

func _ready():
	fsm = get_node(fsm_path)

func change_state():
	if not Input.is_action_pressed("ui_up"):
		fsm.change_state(get_node(falling_state_path))
	elif fsm.body.on_ground():
		fsm.change_state(get_node(idle_state_path))

func on_enter():
	#print("enter jumping")
	pass

func update(delta):
	var direction = Vector2(0,0)
	
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		
	if Input.is_action_pressed("ui_up"):
		direction.y = -1.5
		
	fsm.body.move_and_slide(direction.normalized() * speed)

func on_leave():
	#print("leave jumping")
	pass
