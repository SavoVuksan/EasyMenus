extends Control

@onready var start_game_button: Button = $%StartGameButton
@onready var options_menu: Control = $%OptionsMenu
@onready var content: Control = $%Content 

func _ready():
	start_game_button.grab_focus()

func quit():
	get_tree().quit()
	
func open_options():
	options_menu.show()
	content.hide()
	options_menu.on_open()
	
func close_options():
	content.show();
	start_game_button.grab_focus()
	options_menu.hide()
