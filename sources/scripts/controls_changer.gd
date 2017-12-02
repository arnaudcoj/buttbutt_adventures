extends Area2D

# TODO export with enum when available

export(int, "Left", "Right", "Up", "Down", "RunLeft", "RunRight", "Jump") var left_control
export(int, "Left", "Right", "Up", "Down", "RunLeft", "RunRight", "Jump") var right_control

func _ready():
	connect("area_entered", self, "on_area_entered")
	
func on_area_entered(area):
	if area.has_method("change_controls"):
		area.change_controls(left_control, right_control)
		$Particles2D.emitting = true
