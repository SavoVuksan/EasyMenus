extends Control
class_name OptionsMenuController
signal  close

@onready var sfx_volume_slider : HSlider = $%SFXVolumeSlider
@onready var music_volume_slider: HSlider = $%MusicVolumeSlider
@onready var fullscreen_check_button: CheckButton = $%FullscreenCheckButton
@onready var render_scale_current_value_label: Label = $%RenderScaleCurrentValueLabel
@onready var render_scale_slider: HSlider = $%RenderScaleSlider

var sfx_bus_index
var music_bus_index
var config = ConfigFile.new()


# Emits close signal and saves the options
func go_back():
	save_options()
	emit_signal("close")

# Called from outside initializes the options menu
func on_open():
	sfx_bus_index = AudioServer.get_bus_index(OptionsConstants.sfx_bus_name)
	music_bus_index = AudioServer.get_bus_index(OptionsConstants.music_bus_name)
	
	load_options()

func _on_sfx_volume_slider_value_changed(value):
	set_volume(sfx_bus_index, value)

func _on_music_volume_slider_value_changed(value):
	set_volume(music_bus_index, value)

# Sets the volume for the given audio bus
func set_volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	print(bus_index, AudioServer.get_bus_volume_db(bus_index))
	
# Saves the options when the options menu is closed
func save_options():
	config.set_value(OptionsConstants.section_name,OptionsConstants.sfx_volume_key_name, sfx_volume_slider.value)
	config.set_value(OptionsConstants.section_name, OptionsConstants.music_volume_key_name, music_volume_slider.value)
	config.set_value(OptionsConstants.section_name, OptionsConstants.fullscreen_key_name, fullscreen_check_button.button_pressed)
	config.set_value(OptionsConstants.section_name, OptionsConstants.render_scale_key, render_scale_slider.value);
	config.save(OptionsConstants.config_file_name)

# Loads options and sets the controls values to loaded values. Uses default values if config file
# does not exist
func load_options():
	var err = config.load(OptionsConstants.config_file_name)
	
	if err != OK:
		return
	
	var sfx_volume = config.get_value(OptionsConstants.section_name, OptionsConstants.sfx_volume_key_name, 1)
	var music_volume = config.get_value(OptionsConstants.section_name, OptionsConstants.music_volume_key_name, 1)
	var fullscreen = config.get_value(OptionsConstants.section_name, OptionsConstants.fullscreen_key_name, false)
	var render_scale = config.get_value(OptionsConstants.section_name, OptionsConstants.render_scale_key, 1)
	
	sfx_volume_slider.value = sfx_volume
	music_volume_slider.value = music_volume
	fullscreen_check_button.button_pressed = fullscreen
	render_scale_slider.value = render_scale
	


func _on_fullscreen_check_button_toggled(button_pressed):
	if button_pressed:
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		

func _on_render_scale_slider_value_changed(value):
	get_viewport().scaling_3d_scale = value
	render_scale_current_value_label.text = str(value)
