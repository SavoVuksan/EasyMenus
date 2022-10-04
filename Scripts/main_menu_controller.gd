extends Control

@onready var options_menu: Control = $%OptionsMenu
@onready var content: Control = $%Content 

func quit():
	get_tree().quit()
	
func open_options():
	options_menu.show()
	content.hide()
	options_menu.on_open()
	
func close_options():
	content.show();
	options_menu.hide()


# Just a test remove when not needed anymore
func load_3d_scene():
	get_tree().change_scene_to_file("res://Scenes/test_3d_scene.tscn")
