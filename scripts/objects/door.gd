extends Switchable

onready var animation_player := $AnimationPlayer

func on_activated():
	if animation_player.is_playing():
		return
	
	if active:
		animation_player.play("open")
	else:
		animation_player.play_backwards("open")
