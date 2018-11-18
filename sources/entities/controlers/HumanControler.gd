extends Node

var body : KinematicBody2D
var velocity := Vector2(0,0)
var jumping := false
var falling := true

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
	# reset jump state when colliding with ceiling or floor (not on walls, allow to slide against them)
	if body.is_on_ceiling() or body.is_on_floor():
		jumping = false
		falling = body.is_on_ceiling()
		velocity.y = 0
	
	# reset jump state when starting to fall
	if jumping and velocity.y > 0:
		jumping = false
		falling = true
	
	# physic used when the character is on the ground
	if body.is_on_floor():
		# left direction
		if Input.is_action_pressed("ui_left"):
			# fetch slope normal
			var normal = body.get_left_ground_normal()
			# fetch opposite slope normal (used for descending slope)
			if normal == null:
				normal = body.get_right_ground_normal()
				# avoid following slope angle when there is no ground in the input direction
				if normal != null and normal.dot(Vector2.UP) > 0:
					normal = null
			# use horizontal movement if no slope found
			if normal == null:
				normal = Vector2.UP
			
			# use normal informations to move along slope direction
			velocity.x = -500 * abs(normal.y)
			velocity.y = -500 * normal.x
			
		# right direction
		elif Input.is_action_pressed("ui_right"):
			# fetch slope normal
			var normal = body.get_right_ground_normal()
			# fetch opposite slope normal (used for descending slope)
			if normal == null:
				normal = body.get_left_ground_normal()
				# avoid following slope angle when there is no ground in the input direction
				if normal != null and normal.dot(Vector2.UP) > 0:
					normal = null
			# use horizontal movement if no slope found
			if normal == null:
				normal = Vector2.UP

			# use normal informations to move along slope direction
			velocity.x = 500 * abs(normal.y)
			velocity.y = 500 * normal.x
			
		# no direction
		else:
			velocity.x = 0
			velocity.y = 0
		
		# jump
		if Input.is_action_just_pressed("ui_up") and not jumping:
			velocity.y = -1000
			jumping = true
			falling = false
			
	# physics used when in air
	else:
		if Input.is_action_pressed("ui_left"):
			velocity.x = -400
		elif Input.is_action_pressed("ui_right"):
			velocity.x = 400
		else:
			velocity.x = 0
			
		velocity.y += 2000 * delta
		falling = true
	
	# Calls to KinematicBody2D functions
	if jumping or (falling and body.is_on_wall()):
		body.move_and_slide(velocity, Vector2(0, -1), true, false, 4, 0.85)
	elif falling:
		body.move_and_slide(velocity, Vector2.UP, true, false, 1)
	else:
		if velocity.x != 0:
			body.move_and_slide_with_snap(velocity, Vector2(0, 32), Vector2.UP, true, false, 4, 0.85)
			