extends GameState

onready var _camera := $Camera2D
onready var _anim_player := $AnimationPlayer

enum STATE {
	Main,
	Settings,
	Wildcards,
	Transitioning,
}

var _state: int = STATE.Main


func _set_state(var new):
	if _state == new or _anim_player.is_playing():
		return
	match new:
		STATE.Main:
			if _state == STATE.Settings:
				_anim_player.play_backwards("to_settings")
			elif _state == STATE.Wildcards:
				_anim_player.play_backwards("to_wildcards")
		STATE.Settings:
			_anim_player.play("to_settings")
		STATE.Wildcards:
			_anim_player.play("to_wildcards")
	_state = new

func _on_ButtonPlay_pressed():
	Global.transition_to(Global.GAME)


func _on_ButtonSettings_pressed():
	_set_state(STATE.Settings)


func _on_ButtonExit_pressed():
	Global.set_state(Global.STATE.Exiting)


func _on_ButtonBack_pressed():
	_set_state(STATE.Main)


func _on_ButtonWildcards_pressed():
	_set_state(STATE.Wildcards)
