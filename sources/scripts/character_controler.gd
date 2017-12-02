extends Node

export (NodePath) var target
var body

var current_speed = Vector2()

# Don't forget to add to controls_changer if add more controls
enum Control {Left, Right, Up, Down, RunLeft, RunRight, Jump}
var left_control = Control.Left
var right_control = Control.Right

export (NodePath) var init_state_path
var current_state

func _ready():
	current_state = get_node(init_state_path)
	body = get_node(target)
	assert(body is KinematicBody2D)

func _physics_process(delta):
	var old_pos = body.position
	current_state.change_state()
	current_state.update(delta)
	current_speed = (body.position - old_pos) / delta
	$"../buttbutt_animation".play(current_state.get_name()) # TODO animation tree

func change_state(new_state):
		current_state.on_leave()
		current_state = new_state
		print(new_state.get_name())
		current_state.on_enter()
		
func is_control_pressed(control):
	return left_control == control and controls_manager.is_left_control_pressed() or right_control == control and controls_manager.is_right_control_pressed()

func change_controls(new_left_control, new_right_control):
	left_control = new_left_control
	right_control = new_right_control