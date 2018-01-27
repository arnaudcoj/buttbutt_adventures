extends Control

var left_tween
var right_tween

onready var fps_label = $fps_label

var timer = 0
var frame_counter = 0

func _ready():
	pass
	
func _physics_process(delta):
	timer += delta
	frame_counter += 1
	
	if timer > 1.0:
		fps_label.set_text(str(Engine.get_frames_per_second()) + " fps\nphysics : " + str(frame_counter) + " fps")
		timer = fmod(timer, 1.0)
		frame_counter = 0

func on_controls_changed(new_left_control, new_right_control):
	left_tween = $LeftTween
	left_tween.interpolate_property(get_node("LeftControl/LeftButton"), "scale", Vector2(2.5,2.5), Vector2(2,2), 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	right_tween = $RightTween
	right_tween.interpolate_property(get_node("RightControl/RightButton"), "scale", Vector2(2.5,2.5), Vector2(2,2), 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)

	get_node("LeftControl/LeftButton/Label").set_text(Controls.to_string(new_left_control))
	left_tween.start()
	get_node("RightControl/RightButton/Label").set_text(Controls.to_string(new_right_control))
	right_tween.start()