extends KinematicBody2D

signal dead
signal goal
signal controls

var velocity := Vector2()

export (NodePath) var controler_path
onready var controler = get_node(controler_path)

onready var ground_raycasters = $GroundRaycasters
onready var ledge_detectors = $LedgeDetectors

func _ready():
	connect("controls", controler, "update_controls")

func _on_area_entered(area : Area2D):
	if area.is_in_group("death"):
		print("dead")
		emit_signal("dead")
	elif area.is_in_group("goal"):
		print("goal")
		emit_signal("goal")
	elif area.is_in_group("controls"):
		print("controls changed : ", area.left_action, area.right_action)
		emit_signal("controls", area.left_action, area.right_action)

func can_grab_left_ledge():
	if is_on_wall():
		var ledge_position = null
		if velocity.x < 0:
			ledge_position = ledge_detectors.left_ledge_detector.get_ledge_position()
		return ledge_position != null
	return false

func can_grab_right_ledge():
	if is_on_wall():
		var ledge_position = null
		if velocity.x > 0:
			ledge_position = ledge_detectors.right_ledge_detector.get_ledge_position()
		return ledge_position != null
	return false

func on_pause():
	controler.reset()