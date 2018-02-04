extends Node

# Don't forget to add to controls_changer if add more controls
var left_control = Controls.Left
var right_control = Controls.Right

onready var body = get_parent()
onready var anim = body.get_node("buttbutt_animation")

onready var state = $idle

var velocity = Vector2()
	
export var jump_height = 200
export var time_to_jump_apex = 0.4
export var acceleration_time_airborne = 0.2
export var acceleration_time_grounded = 0.1
export var move_speed = 600

var gravity
var jump_velocity

func _ready():
	gravity = (2.0 * jump_height) / pow(time_to_jump_apex, 2.0)
	jump_velocity = abs(gravity) * time_to_jump_apex
	body.emit_signal("change_controls", left_control, right_control)

func _physics_process(delta):
	state.change_state()
	state.update(delta)
	#todo better
	if (state.name == "idle"):
		anim.playback_speed = 1
	else:
		anim.playback_speed = velocity.length() / move_speed
	
func change_state(new_state):
	print(new_state.get_name())
	anim.play(new_state.get_name())
	state.on_leave()
	state = new_state
	state.on_enter()

func is_control_pressed(control):
	return left_control == control and controls_manager.is_left_control_pressed() or right_control == control and controls_manager.is_right_control_pressed()

func change_controls(new_left_control, new_right_control):
	left_control = new_left_control
	right_control = new_right_control
	body.emit_signal("change_controls", new_left_control, new_right_control)
	
func move(motion):
	body.move(motion)