extends Control

func update_controls_icons(left_action, right_action):
	$LeftControlButton.update_control_icon(left_action)
	$RightControlButton.update_control_icon(right_action)