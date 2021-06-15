extends PlayerState


func enter_state():
	player.animated_sprite.play("idle")


func tick(var delta: float):
	pass
