extends GameState


enum STATE {
	Main,
	Settings,
	Wildcards,
	Transitioning,
}

onready var _camera := $Camera2D
onready var _anim_player := $AnimationPlayer
onready var button_exit := $HBoxContainer/ContainerMain/MarginContainer/HBoxContainer/VBoxContainer/ButtonExit

var _state: int = STATE.Main
var audio_bus_master: int = AudioServer.get_bus_index("Master")
var audio_bus_music: int = AudioServer.get_bus_index("Music")
var audio_bus_sound: int = AudioServer.get_bus_index("Sound")


func _ready():
	if OS.get_name() == "HTML5":
		button_exit.disabled = true


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
	Global.set_state(Global.STATE.Intro)


func _on_ButtonSettings_pressed():
	_set_state(STATE.Settings)


func _on_ButtonExit_pressed():
	Global.set_state(Global.STATE.Exiting)


func _on_ButtonBack_pressed():
	_set_state(STATE.Main)


func _on_ButtonWildcards_pressed():
	_set_state(STATE.Wildcards)


func _on_HSliderMaster_value_changed(value):
	AudioServer.set_bus_volume_db(audio_bus_master, linear2db(value))


func _on_HSliderMusic_value_changed(value):
	AudioServer.set_bus_volume_db(audio_bus_music, linear2db(value))


func _on_HSliderSound_value_changed(value):
	AudioServer.set_bus_volume_db(audio_bus_sound, linear2db(value))
