extends "res://entities/buttbutt/fsm/fsm_state.gd"

func get_next_state():
	if Input.is_action_just_pressed("jump"):
		return $"../Jump"
	if not Input.is_action_pressed("walk_left") and not Input.is_action_pressed("walk_right"):
		return $"../Idle"
	if not body.is_on_floor():
		return $"../Fall"

func update_physics(delta):
	body.velocity.x = 0
	body.velocity.y = 0
	
	if Input.is_action_pressed("walk_left") and Input.is_action_pressed("walk_right"):
		pass
		
	# left direction
#	if Input.is_action_pressed("ui_left") and last_action != "ui_right":
#		last_action = "ui_left"
	elif Input.is_action_pressed("walk_left"):
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
		body.velocity.x -= 500 * abs(normal.y)
		body.velocity.y -= 500 * normal.x
		
	# right direction
#	if Input.is_action_pressed("ui_right") and last_action != "ui_left":
#		last_action = "ui_right"
	elif Input.is_action_pressed("walk_right"):
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
		body.velocity.x += 500 * abs(normal.y)
		body.velocity.y += 500 * normal.x
			
	if body.velocity.x != 0:
		body.move_and_slide_with_snap(body.velocity, Vector2(0, 32), Vector2.UP, true, false, 4, 0.85)