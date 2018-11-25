extends "res://entities/buttbutt/fsm/fsm_state.gd"

func get_next_state():
	if body.is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
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
	
	if Input.is_action_pressed("ui_up"):
		body.velocity.y -= 800 * delta
		
#	if Input.is_action_pressed("ui_left") and last_action != "ui_right":
#		last_action = "ui_left"
	if Input.is_action_pressed("ui_left"):
		body.velocity.x -= 400
#	if Input.is_action_pressed("ui_right") and last_action != "ui_left":
#		last_action = "ui_right"
	if Input.is_action_pressed("ui_right"):
		body.velocity.x += 400
	
	body.velocity.y += 2000 * delta
	
	body.move_and_slide(body.velocity, Vector2(0, -1), true, false, 4, 0.85)

func enter_state():
	print("enter ", name)
	body.velocity.y = -800