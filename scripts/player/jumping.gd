extends PlayerState


func enter_state():
	player.velocity.y = Player.JUMP_VELOCITY
	if abs(player.velocity.x) > Player.WALKING_TRESHOLD:
		player.animated_sprite.play("jump_walking")
	else:
		player.animated_sprite.play("jump_standing")


func physics_tick(var delta: float):
	fsm.get_node("Walking").physics_tick(delta)
