extends Node2D
const PauseMenu = preload("res://addons/MenuTemplates/Scripts/pause_menu_controller.gd");


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	var pause_menu := (get_child(0).get_child(0) as PauseMenu) 
	if event.is_action_pressed("pause"):
		pause_menu.open_pause_menu()
