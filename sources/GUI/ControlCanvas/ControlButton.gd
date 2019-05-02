extends Control

export var action := "ui_select"

export (Theme) var controls_theme

var touch_id = null

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if touch_id == null and is_inside(event.position):
				touch_id = event.index
				Input.action_press(action)
		else:
			if event.index == touch_id:
				touch_id = null
				Input.action_release(action)
			
func is_inside(position : Vector2) -> bool:
	return (rect_position.x <= position.x and position.x <= rect_position.x + rect_size.x 
	and rect_position.y <= position.y and position.y <= rect_position.y + rect_size.y )

func _exit_tree():
	if touch_id != null:
		Input.action_release(action)

func update_control_icon(new_action):
	$Control/TextureRect.texture = controls_theme.get_icon(new_action, "controls")
	#$Control/TextureRect.texture = sprites[new_action]