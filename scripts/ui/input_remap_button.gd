extends Button

export(String) var action = "<action name>"

func _ready():
	assert(InputMap.has_action(action))
	set_process_input(false)
	display_current_key()


func _toggled(button_pressed):
	if button_pressed:
		set_process_input(true)
		text = "..."
		release_focus()
	else:
		set_process_input(false)
		display_current_key()


func _input(event):
	if event is InputEventKey or event is InputEventJoypadButton:
		remap_action_to(event)
		pressed = false


func remap_action_to(event):
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)
	text = event.as_text()


func display_current_key():
	var current_key = InputMap.get_action_list(action)[0].as_text()
	text = current_key
