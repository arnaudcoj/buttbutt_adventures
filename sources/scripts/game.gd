extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$canvas/home_screen.show()
	$canvas/level_selector.hide()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func load_level(level):
	$canvas/home_screen.hide()
	$canvas/level_selector.hide()
	for current_level in $level_container.get_children():
		current_level.queue_free()
	$level_container.add_child(level.instance())

func on_level_selected(level):
	load_level(level)

func on_start_pressed():
	$canvas/home_screen.hide()
	$canvas/level_selector.show()