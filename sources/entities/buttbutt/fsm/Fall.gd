extends "res://entities/buttbutt/fsm/fsm_state.gd"

func get_next_state():
	if body.is_on_floor():
		if Input.is_action_pressed("walk_left") or Input.is_action_pressed("walk_right"):
			return $"../Walk"
		else:
			return $"../Idle"

func update_physics(delta):
	body.velocity.x = 0
		
#	if Input.is_action_pressed("ui_left") and last_action != "ui_right":
#		last_action = "ui_left"
	if Input.is_action_pressed("walk_left"):
		body.velocity.x -= 400
#	if Input.is_action_pressed("ui_right") and last_action != "ui_left":
#		last_action = "ui_right"
	if Input.is_action_pressed("walk_right"):
		body.velocity.x += 400
	
	body.velocity.y += 2000 * delta
	
	if body.is_on_wall():
		body.move_and_slide(body.velocity, Vector2(0, -1), true, 4, 0.85)
	else:
		body.move_and_slide(body.velocity, Vector2.UP, true, 1)
