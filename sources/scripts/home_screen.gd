extends Control

signal start_pressed

func _ready():
	controls_manager.enabled = false
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_start_pressed():
	emit_signal("start_pressed")
	controls_manager.enabled = true
	hide()
