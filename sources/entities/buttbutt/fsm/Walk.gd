extends FSMState

var ghost_jump_started := false
var ghost_jump_timer := .0

func get_next_state():
	if Input.is_action_just_pressed("jump"):
		return $"../Jump"
	if Input.is_action_pressed("walk_left") == Input.is_action_pressed("walk_right"):
		if ghost_jump_started:
			return $"../Fall"
		else:
			return $"../Idle"
	if not body.is_on_floor():
		if ghost_jump_started :
			if body.ghost_jump_time <= 0 || ghost_jump_timer > body.ghost_jump_time \
			 || (Input.is_action_pressed("walk_left") && body.velocity.x > 0) \
			 || (Input.is_action_pressed("walk_right") && body.velocity.x < 0):
				return $"../Fall"
		elif !ghost_jump_started:
			ghost_jump_started = true

func enter_state():
	.enter_state()
	body.skeleton.play("Walk")
	ghost_jump_started = false
	ghost_jump_timer = .0
	
func leave_state():
	.leave_state()

func update_physics(delta):
	body.velocity.y += body.gravity * delta
	
	if Input.is_action_pressed("walk_left"):
		body.velocity.x = clamp(body.velocity.x - body.acceleration_factor * delta, -body.horizontal_speed, -body.horizontal_start_speed)
	elif Input.is_action_pressed("walk_right"):
		body.velocity.x = clamp(body.velocity.x + body.acceleration_factor * delta, body.horizontal_start_speed, body.horizontal_speed)
	
	if body.velocity.x != 0:
		var motion = body.move_and_slide_with_snap(body.velocity, body.snap_vector, body.up_vector, true, 4, body.floor_max_angle)
		
		if body.is_on_wall() and body.fix_step_height():
			motion += body.move_and_slide_with_snap(body.velocity - motion, body.snap_vector, body.up_vector, true, 4 , body.floor_max_angle)
		
		body.velocity.y = motion.y

		if body.velocity.x > 0:
			body.skeleton.flip(ButtButtSkeleton.ORIENTATION_RIGHT)
		else:
			body.skeleton.flip(ButtButtSkeleton.ORIENTATION_LEFT)
		
	body.skeleton.set_speed(abs(body.velocity.x) / body.horizontal_speed)
	
	# process ghost_jump
	if ghost_jump_started and ghost_jump_timer < body.ghost_jump_time :
		ghost_jump_timer += delta
	
