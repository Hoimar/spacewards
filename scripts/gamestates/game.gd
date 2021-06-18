class_name Game
extends Control


onready var hud := $HUD


func _process(var delta: float):
	if Input.is_action_pressed("pause"):
		Global.set_state(Global.STATE.Pause)
