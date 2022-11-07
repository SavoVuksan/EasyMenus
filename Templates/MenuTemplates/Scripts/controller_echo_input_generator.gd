extends Node

var echo_event = null

@onready var echo_timer : Timer = $EchoTimer
@onready var waiting_timer : Timer = $WaitingTimer
# Called when the node enters the scene tree for the first time.
func _ready():
	for joypad_id in Input.get_connected_joypads():
		print(Input.get_joy_name(joypad_id), joypad_id)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventJoypadButton:
		echo_event = event
		if event.pressed and (event.is_action("ui_up") or event.is_action("ui_down") or event.is_action("ui_left") or event.is_action("ui_right")):
			waiting_timer.start()
		else:
			waiting_timer.stop()
			echo_timer.stop()

func _on_echo_timer_timeout():
	Input.parse_input_event(echo_event)

func _on_waiting_timer_timeout():
	echo_timer.start()