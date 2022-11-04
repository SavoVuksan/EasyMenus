extends Control
signal resume

@onready var content : VBoxContainer = $%Content
@onready var options_menu = $%OptionsMenu
@onready var resume_game_button: Button = $%ResumeGameButton
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func open_pause_menu():
	#Stops game and shows pause menu
	get_tree().paused = true
	show()
	resume_game_button.grab_focus()
	
func close_pause_menu():
	get_tree().paused = false
	hide()
	emit_signal("resume")

func _on_resume_game_button_pressed():
	close_pause_menu()


func _on_options_button_pressed():
	content.hide()
	options_menu.show()
	options_menu.on_open()


func _on_options_menu_close():
	options_menu.hide()
	content.show()
	resume_game_button.grab_focus()

func _on_quit_button_pressed():
	get_tree().quit()


func _on_back_to_menu_button_pressed():
	close_pause_menu()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		accept_event()
		close_pause_menu()
