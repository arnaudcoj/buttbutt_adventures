extends Node

export (NodePath) var target
var body

export (NodePath) var init_state_path
var current_state

func _ready():
	current_state = get_node(init_state_path)
	body = get_node(target)
	assert(body is KinematicBody2D)

func _process(delta):
	current_state.change_state()
	current_state.update(delta)