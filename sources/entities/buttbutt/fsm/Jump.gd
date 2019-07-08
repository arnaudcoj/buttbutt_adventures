extends FSMState

func get_next_state():
	if body.is_on_floor():
		if Input.is_action_pressed("walk_left") or Input.is_action_pressed("walk_right"):
			return $"../Walk"
		else:
			return $"../Idle"
	else:
		if body.velocity.y >= 0:
			return $"../Fall"

func update_physics(delta):
	body.velocity.x = 0
	
	if body.is_on_ceiling():
		body.velocity.y = 0
	
	if Input.is_action_pressed("jump"):
		body.velocity.y -= 800 * delta
		
#	if Input.is_action_pressed("ui_left") and last_action != "ui_right":
#		last_action = "ui_left"
	if Input.is_action_pressed("walk_left"):
		body.velocity.x -= 400
#	if Input.is_action_pressed("ui_right") and last_action != "ui_left":
#		last_action = "ui_right"
	if Input.is_action_pressed("walk_right"):
		body.velocity.x += 400
	
	body.velocity.y += 2000 * delta
	
	# todo better placement
	if body.is_on_wall():
		var ledge_position = null
		if body.velocity.x < 0:
			ledge_position = body.ledge_detectors.left_ledge_detector.get_ledge_position()
		elif body.velocity.x > 0:
			ledge_position = body.ledge_detectors.right_ledge_detector.get_ledge_position()
		if ledge_position != null:
			body.position.y = ledge_position.y - 2
	
	body.move_and_slide(body.velocity, Vector2(0, -1), true, 4, 0.85)

func enter_state():
	print("enter ", name)
	body.velocity.y = -800