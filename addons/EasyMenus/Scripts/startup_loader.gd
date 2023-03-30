extends Node
#Loads options like volume and graphic options on game startup

var config = ConfigFile.new()

# Loads settings from config file. Loads with standard values if settings not 
# existing
func load_settings():
	var err = config.load(OptionsConstants.config_file_name)
	
	if err != OK:
		return
	
	for bus_index in range(AudioServer.bus_count):
		var bus_name := AudioServer.get_bus_name(bus_index)
		var volume_key_name := bus_name + "_volume"
		var volume := linear_to_db(config.get_value(OptionsConstants.section_name, volume_key_name, 1))
		AudioServer.set_bus_volume_db(bus_index, volume)
	
	var fullscreen = config.get_value(OptionsConstants.section_name, OptionsConstants.fullscreen_key_name, false)
	var render_scale = config.get_value(OptionsConstants.section_name, OptionsConstants.render_scale_key, 1)
	var vsync = config.get_value(OptionsConstants.section_name, OptionsConstants.vsync_key, true)
	var msaa_2d = config.get_value(OptionsConstants.section_name, OptionsConstants.msaa_2d_key, 0)
	var msaa_3d = config.get_value(OptionsConstants.section_name, OptionsConstants.msaa_3d_key, 0)
	
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	get_viewport().scaling_3d_scale = render_scale
	
	if vsync:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
	set_msaa("msaa_2d", msaa_2d)
	set_msaa("msaa_3d", msaa_3d)
	
func _ready():
	load_settings()

func set_msaa(mode, index):
	match index:
		0:
			get_viewport().set(mode, Viewport.MSAA_DISABLED)
		1:
			get_viewport().set(mode, Viewport.MSAA_2X)
		2:
			get_viewport().set(mode, Viewport.MSAA_4X)
		3:
			get_viewport().set(mode, Viewport.MSAA_8X)
