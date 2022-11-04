extends Node

@export var enabled: bool = true
@export var focus_sound : AudioStream
@export var select_sound : AudioStream
@export var back_sound : AudioStream
@export var ui : Control
@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_all_children(ui):
		print(child.get_class())
		if child.is_class("Button") or child.is_class("HSlider"):
			child.connect("focus_entered",focus_entered)
		if child.is_class("HSlider"):
			child.connect("value_changed", value_changed)
		if child.is_class("Button"):
			child.connect("pressed", pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func focus_entered():
	if !enabled:
		return
	audio_player.stream = focus_sound
	audio_player.play()

func pressed():
	if !enabled:
		return
	audio_player.stream = select_sound
	audio_player.play()

func value_changed(_value):
	if !enabled:
		return
	audio_player.stream = focus_sound
	audio_player.play()

func get_all_children(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr
