# Godot Menu Template
This plugin adds a basic main, options and pause menu to your project.
## Intended Use
Its intended to be used during gamejams to save some time on menus. Menus are nice to have but most of the time not a priority at gamejames. So here we come to help. You can also use it in a regular project as a temporary menu or just as the full thing. Use it as what ever your heart pleases.
## Features
* Keyboard/Gamepad support
* Autoloading of settings on startup
### Main Menu
![Main Menu](Screenshots/main_menu.png)
* Game Title
* Start Button
* Options Button
* Quit Button

Just connect your scene loading logic to the `pressed` signal of the start button and you are good to go. 
### Options Menu
![Main Menu](Screenshots/options_menu.png)
The options menu loads and persists the settings when opened/closed. The data is saved in the `user://options.cfg` file.

The Options menu offers following settings to be changed
* SFX Volume
* Music Volume
* Fullscreen mode
* VSync
* Render Scale for 3D Scenes
* Anti Aliasing 2D
* Anti Aliasing 3D

You open the option menu with the `on_open` method. 

The menu emits a `close` `signal` when closed. With this architecture the parent control node decides what to do when the options menu is closed. 
### Pause Menu  
![Main Menu](Screenshots/pause_menu.png)
The pause menu is called via the `open_pause_menu` method. It pauses the game and opens the menu. 

To close it via code just call the `close_pause_menu` method.

The menu encorperates following functions
* Resume the game
* Access to the options menu
* Back to main menu
* Quit the game

## How to use
* Add the `options_constants.gd` and `startup_loader.gd` to the autoload of your project.
* The order must be `options_constants` first then the `startup_loader` script
* For the Audio Sliders to work properly you need to create 2 Audio Busses one called `SFX` and the other called `Music` 
