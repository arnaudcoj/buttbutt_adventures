extends Node

export (NodePath) var fsm_path
var fsm
var body

export (NodePath) var idle_state_path
var idle_state

export var speed = 500

func _ready():
	fsm = get_node(fsm_path)
	idle_state = get_node(idle_state_path)

func update(delta):
	var direction = Vector2(0,0)
	
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
		
	fsm.body.move_and_slide(direction.normalized() * speed)

func change_state():
	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		on_leave()
		fsm.current_state = idle_state
		fsm.current_state.on_enter()

func on_enter():
	print("enter walk")
	
func on_leave():
	print("leave walk")
