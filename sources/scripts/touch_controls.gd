extends Control

var left_tween
var right_tween

func _ready():
	pass

func on_controls_changed(new_left_control, new_right_control):
	left_tween = $LeftTween
	left_tween.interpolate_property(get_node("LeftControl/LeftButton"), "scale", Vector2(2.5,2.5), Vector2(2,2), 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)
	right_tween = $RightTween
	right_tween.interpolate_property(get_node("RightControl/RightButton"), "scale", Vector2(2.5,2.5), Vector2(2,2), 0.5, Tween.TRANS_BACK, Tween.EASE_OUT)

	get_node("LeftControl/LeftButton/Label").set_text(Controls.to_string(new_left_control))
	left_tween.start()
	get_node("RightControl/RightButton/Label").set_text(Controls.to_string(new_right_control))
	right_tween.start()