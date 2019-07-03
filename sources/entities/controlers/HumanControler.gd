extends Node

var body : KinematicBody2D

var left_action = "walk_left"
var right_action = "walk_right"

func _ready():
	body = get_parent()
	body.emit_signal("controls", left_action, right_action)

func _input(event):
	# change time scale
	if event.is_action_pressed("ui_page_up"):
		Engine.time_scale *= 2
	elif event.is_action_pressed("ui_page_down"):
		Engine.time_scale *= 0.5
	# reset time scale
	elif event.is_action_pressed("ui_end"):
		Engine.time_scale = 1

func _exit_tree():
	if Input.is_action_pressed(left_action):
		Input.action_release(left_action)
	if Input.is_action_pressed(right_action):
		Input.action_release(right_action)

func _process(delta):
	if Input.is_action_just_pressed("left_action"):
		Input.action_press(left_action)
	elif Input.is_action_just_released("left_action"):
		Input.action_release(left_action)
		
	if Input.is_action_just_pressed("right_action"):
		Input.action_press(right_action)
	elif Input.is_action_just_released("right_action"):
		Input.action_release(right_action)
	
#	if Input.is_action_just_released("ui_left") and last_action == "ui_left":
#		if Input.is_action_pressed("ui_right"):
#			last_action = "ui_right"
#		else:
#			last_action = ""
#	if Input.is_action_just_released("ui_right") and last_action == "ui_right":
#		if Input.is_action_pressed("ui_left"):
#			last_action = "ui_left"
#		else:
#			last_action = ""

func update_controls(new_left_action, new_right_action):
	if left_action != new_left_action:
		if Input.is_action_pressed(left_action):
			Input.action_release(left_action)
		left_action = new_left_action
	
	if right_action != new_right_action:
		if Input.is_action_pressed(right_action):
			Input.action_release(right_action)
		right_action = new_right_action

func reset():
	Input.action_release(left_action)
	Input.action_release(right_action)