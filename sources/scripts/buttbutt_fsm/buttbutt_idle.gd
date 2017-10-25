extends Node

export (NodePath) var fsm_path
var fsm

export (NodePath) var walk_state_path
export (NodePath) var running_state_path
export (NodePath) var falling_state_path
export (NodePath) var climbing_state_path

func _ready():
	fsm = get_node(fsm_path)

func change_state():
	if not fsm.body.on_ground():
		fsm.change_state(get_node(falling_state_path))
	elif fsm.is_control_pressed(fsm.Control.Up) and fsm.body.can_climb():
		fsm.change_state(get_node(climbing_state_path))
	elif fsm.is_control_pressed(fsm.Control.RunLeft) or fsm.is_control_pressed(fsm.Control.RunRight) :
		fsm.change_state(get_node(running_state_path))
	elif fsm.is_control_pressed(fsm.Control.Left) or fsm.is_control_pressed(fsm.Control.Right) :
		fsm.change_state(get_node(walk_state_path))

func on_enter():
	#print("enter idle")
	pass

func update(delta):
	pass

func on_leave():
	#print("leave idle")
	pass

