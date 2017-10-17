extends Node

export (NodePath) var fsm_path
var fsm

export (NodePath) var walk_state_path
export (NodePath) var falling_state_path
export (NodePath) var jumping_state_path

func _ready():
	fsm = get_node(fsm_path)

func change_state():
	if not fsm.body.on_ground():
		fsm.change_state(get_node(falling_state_path))
	elif Input.is_action_pressed("ui_up") :
		fsm.change_state(get_node(jumping_state_path))
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") :
		fsm.change_state(get_node(walk_state_path))

func on_enter():
	#print("enter idle")
	pass

func update(delta):
	pass

func on_leave():
	#print("leave idle")
	pass

