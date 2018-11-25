extends Node

var body : KinematicBody2D

var last_action := ""

func _ready():
	body = get_parent()

func _input(event):
	# change time scale
	if event.is_action_pressed("ui_page_up"):
		Engine.time_scale *= 2
	elif event.is_action_pressed("ui_page_down"):
		Engine.time_scale *= 0.5
	# reset time scale
	elif event.is_action_pressed("ui_end"):
		Engine.time_scale = 1
		
	# reset scene
	elif event.is_action_pressed("ui_select"):
		get_tree().reload_current_scene()

func _physics_process(delta):
	if Input.is_action_just_released("ui_left") and last_action == "ui_left":
		if Input.is_action_pressed("ui_right"):
			last_action = "ui_right"
		else:
			last_action = ""
	if Input.is_action_just_released("ui_right") and last_action == "ui_right":
		if Input.is_action_pressed("ui_left"):
			last_action = "ui_left"
		else:
			last_action = ""