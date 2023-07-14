extends Node
const OptionConstants = preload("res://addons/EasyMenus/Scripts/options_constants.gd")
const InputMapUpdater = preload("res://addons/EasyMenus/Scripts/input_map_updater.gd")

var _input_map_updater: InputMapUpdater = null

@onready var ControllerEchoInputGenerator = $ControllerEchoInputGenerator
@onready var startup_loader = $StartupLoader


func _ready():
	_input_map_updater = InputMapUpdater.new()
	_input_map_updater._ready()


func _exit_tree():
	if is_instance_valid(_input_map_updater): 
		_input_map_updater.queue_free()