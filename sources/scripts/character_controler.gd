extends Node

export (NodePath) var target
var body

# Don't forget to add to controls_changer if add more controls
enum Control {Left, Right, Up, Down, RunLeft, RunRight}
var left_control = Control.Left
var right_control = Control.Right

export (NodePath) var init_state_path
var current_state

func _ready():
	current_state = get_node(init_state_path)
	body = get_node(target)
	assert(body is KinematicBody2D)

func _process(delta):
	current_state.change_state()
	current_state.update(delta)

func change_state(new_state):
		current_state.on_leave()
		current_state = new_state
		current_state.on_enter()
		
func is_control_pressed(control):
	return left_control == control and Input.is_action_pressed("left_action") or right_control == control and Input.is_action_pressed("right_action")

func change_controls(new_left_control, new_right_control):
	left_control = new_left_control
	right_control = new_right_control