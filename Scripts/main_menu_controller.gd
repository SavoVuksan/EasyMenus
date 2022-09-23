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


