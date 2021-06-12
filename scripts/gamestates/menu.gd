extends GameState

onready var _camera := $Camera2D
onready var _anim_player := $AnimationPlayer

enum STATE {
	Main,
	Settings,
	Transitioning,
}

var _state: int = STATE.Main


func _set_state(var new):
	if _state == new or _anim_player.is_playing():
		return
	_state = new
	match new:
		STATE.Main:
			_anim_player.play_backwards("transition_menu_screen")
		STATE.Settings:
			_anim_player.play("transition_menu_screen")


func _on_ButtonPlay_pressed():
	Global.transition_to(Global.GAME)


func _on_ButtonSettings_pressed():
	_set_state(STATE.Settings)


func _on_ButtonExit_pressed():
	Global.set_state(Global.STATE.Exiting)


func _on_ButtonBack_pressed():
	_set_state(STATE.Main)
