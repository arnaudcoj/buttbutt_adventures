extends Node

var body : KinematicBody2D
var velocity := Vector2(0,0)
var jumping := false

var full := false

func _ready():
	body = get_parent()

func _input(event):
	if event.is_action_pressed("ui_select"):
		full = not full
	elif event.is_action_pressed("ui_page_up"):
		Engine.time_scale *= 2
	elif event.is_action_pressed("ui_page_down"):
		Engine.time_scale *= 0.5
	elif event.is_action_pressed("ui_end"):
		Engine.time_scale = 1

func _physics_process(delta):
	var on_floor = body.is_on_floor()
	var can_snap = body.can_snap()
	
	if body.can_snap() and not full:
		body.use_snap_collision()
	else:
		body.use_full_collision()
		
	if body.is_on_floor() and not jumping:
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -600
			jumping = true
		else:
			velocity.y = 0
	else:
		velocity.y += 1000 * delta
		jumping = true
	
	if jumping and velocity.y > 0:
		jumping = false
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -500
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 500
	else:
		velocity.x = 0
		
	
	if velocity.length_squared() != 0:
		if jumping:
			body.move_and_slide(velocity, Vector2(0, -1), true, false, 4, 0.9)
		else:
			body.move_and_slide_with_snap(velocity, Vector2(0, 32), Vector2.UP, true, false, 4, 0.9)
#
#	if body.can_snap() and not full:
#		body.use_snap_collision()
#	else:
#		body.use_full_collision()
