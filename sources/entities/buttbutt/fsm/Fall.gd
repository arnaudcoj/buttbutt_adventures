extends FSMState

export var speed := Vector2(400, 0)

onready var timer : Timer = $Timer

var jump_delay_enabled = true

func _input(event):
	if event.is_action_pressed("debug_toggle_platform_helpers"):
		jump_delay_enabled = !jump_delay_enabled
		if jump_delay_enabled:
			print("enable jump delay")
		else:
			print("disable jump delay")

func get_next_state():
	if body.can_jump and Input.is_action_just_pressed("jump"):
		return $"../Jump"
	if Input.is_action_pressed("walk_left") and body.can_grab_left_ledge() \
		or Input.is_action_pressed("walk_right") and body.can_grab_right_ledge():
		return $"../LedgeGrab"
	if body.is_on_floor():
		if Input.is_action_pressed("walk_left") or Input.is_action_pressed("walk_right"):
			return $"../Walk"
		else:
			return $"../Idle"

func enter_state():
	.enter_state()
	timer.connect("timeout", self, "on_timer_timeout")
	if jump_delay_enabled:
		if body.can_jump:
			timer.start()
	else:
		body.can_jump = false
	
	body.skeleton.animation_player.play("Fall")

func leave_state():
	timer.stop()
	timer.disconnect("timeout", self, "on_timer_timeout")
	
func update_physics(delta):
	body.velocity.x = 0
		
#	if Input.is_action_pressed("ui_left") and last_action != "ui_right":
#		last_action = "ui_left"
	if Input.is_action_pressed("walk_left"):
		body.velocity.x -= speed.x
#	if Input.is_action_pressed("ui_right") and last_action != "ui_left":
#		last_action = "ui_right"
	if Input.is_action_pressed("walk_right"):
		body.velocity.x += speed.x
	
	body.velocity.y += 2000 * delta
	
	if body.is_on_wall():
		body.move_and_slide(body.velocity, Vector2(0, -1), true, 4, 0.85)
	else:
		body.move_and_slide(body.velocity, Vector2.UP, true, 1)

func on_timer_timeout():
	body.can_jump = false
