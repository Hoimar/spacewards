extends PlayerState

func enter_state():
	player.animated_sprite.play("dying")


func tick(var delta: float):
	if not player.animated_sprite.is_playing():
		# TODO: Die!
		pass
