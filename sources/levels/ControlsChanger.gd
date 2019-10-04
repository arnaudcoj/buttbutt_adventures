extends Area2D

export var left_action := "walk_left"
export var right_action := "walk_right"

export (Theme) var controls_theme

func _ready():
	update_indicators()
	
func update_indicators():
	$LeftActionIndicator/Sprite.texture = controls_theme.get_icon(left_action, "controls")
	$RightActionIndicator/Sprite.texture = controls_theme.get_icon(right_action, "controls")