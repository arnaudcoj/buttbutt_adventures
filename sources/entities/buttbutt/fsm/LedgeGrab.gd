extends FSMState

var tween_completed := false
export var anim_pixels_by_seconds : float = 500

onready var tween = $Tween

func get_next_state():
	if tween_completed:
		if Input.is_action_just_pressed("jump"):
			return $"../Jump"
		if Input.is_action_pressed("walk_left") or Input.is_action_pressed("walk_right"):
			return $"../Walk"
		if not body.is_on_floor():
			return $"../Fall"
	
func enter_state():
	.enter_state()
	
	tween_completed = false
	tween.connect("tween_all_completed", self, "on_tween_completed")
	
	var origin := body.position
	var destination := get_destination_position()
	var travel := destination - origin
	var time := get_anim_length(travel.length())
	tween.interpolate_property(body, "position", origin, destination, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	body.can_jump = false
	
func leave_state():
	.leave_state()
	tween.disconnect("tween_all_completed", self, "on_tween_completed")
	body.velocity = Vector2.ZERO

func update_physics(delta):
	pass
	
func get_destination_position() -> Vector2 :
	var destination
	if body.can_grab_left_ledge():
		destination = body.ledge_detectors.left_ledge_detector.get_ledge_position()
		destination.x = body.position.x - 5
	elif body.can_grab_right_ledge():
		destination = body.ledge_detectors.right_ledge_detector.get_ledge_position()
		destination.x = body.position.x + 5
	destination.y -= 5
	return destination

func get_anim_length(distance : float) -> float :
	return distance / anim_pixels_by_seconds

func on_tween_completed():
	tween_completed = true