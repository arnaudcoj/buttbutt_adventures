extends FSMState

func get_next_state():
	if Input.is_action_just_pressed("jump"):
		return $"../Jump"
	if Input.is_action_pressed("walk_left") != Input.is_action_pressed("walk_right"):
		return $"../Walk"
	if not body.is_on_floor():
		return $"../Fall"

func enter_state():
	.enter_state()
	body.velocity.y = 0
	body.skeleton.play("Idle")

func update_physics(delta):
	if body.velocity.x != 0:
		body.velocity.x = sign(body.velocity.x) * max(abs(body.velocity.x) - body.deceleration_factor * delta, 0)
	
	if body.velocity.x != 0:
		#body.move_and_slide_with_snap(body.velocity, SNAP_LENGTH, body.up_vector, true, 4, 0.85)
		var motion = body.move_and_slide_with_snap(body.velocity, body.snap_vector, body.up_vector, true, 4, body.floor_max_angle)
		
		if body.is_on_wall() and body.fix_step_height():
			motion += body.move_and_slide_with_snap(body.velocity - motion, body.snap_vector, body.up_vector, true, 4 , body.floor_max_angle)
		
		body.velocity.y = motion.y
		
		if body.velocity.x != 0:
			if body.velocity.x > 0:
				body.skeleton.flip(ButtButtSkeleton.ORIENTATION_RIGHT)
			else:
				body.skeleton.flip(ButtButtSkeleton.ORIENTATION_LEFT)
				
	
	body.skeleton.set_speed(1)
