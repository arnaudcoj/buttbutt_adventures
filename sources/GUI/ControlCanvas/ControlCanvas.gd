extends Control

export (Theme) var controls_theme

func update_controls_icons(left_action, right_action):
	assert(controls_theme != null)
	if $LeftControlButton.controls_theme == null:
		$LeftControlButton.controls_theme = controls_theme
	if $RightControlButton.controls_theme == null:
		$RightControlButton.controls_theme = controls_theme

	$LeftControlButton.update_control_icon(left_action)
	$RightControlButton.update_control_icon(right_action)