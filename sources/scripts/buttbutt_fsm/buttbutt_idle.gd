extends Node

export (NodePath) var fsm_path
var fsm

export (NodePath) var walk_state_path
var walk_state

func _ready():
	fsm = get_node(fsm_path)
	walk_state = get_node(walk_state_path)

func change_state():
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")  or Input.is_action_pressed("ui_up")  or Input.is_action_pressed("ui_down") :
		on_leave()
		fsm.current_state = walk_state
		fsm.current_state.on_enter()

func on_enter():
	print("enter idle")

func update(delta):
	pass

func on_leave():
	print("leave idle")

