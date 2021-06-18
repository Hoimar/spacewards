extends Control


onready var animation_player := $AnimationPlayer
onready var label := $CenterContainer/VBoxContainer/Label
onready var button_resume := $CenterContainer/VBoxContainer/ButtonResume


# Called when the node enters the scene tree for the first time.
func _ready():
	match Global.state:
		Global.STATE.Pause:
			label.text = "Paused"
		Global.STATE.Died:
			label.text = "You died!"
			button_resume.disabled = true


func _on_ButtonResume_pressed():
	Global.set_state(Global.STATE.Ingame)
	queue_free()


func _on_ButtonRestartRoom_pressed():
	Global.set_state(Global.STATE.RestartRoom)
	queue_free()


func _on_ButtonBackToMenu_pressed():
	Global.set_state(Global.STATE.BackToMenu)
	queue_free()
