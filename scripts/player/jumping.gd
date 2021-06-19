extends PlayerState


func enter_state():
	if not player.is_on_floor():
		return
	do_jump()
	if abs(player.velocity.x) > Player.WALKING_TRESHOLD:
		player.animated_sprite.play("jump_walking")
	else:
		player.animated_sprite.play("jump_standing")


func do_jump():
	if player.is_on_floor():
		Global.play_sound(get_node("sfx").stream)
		player.velocity.y = Player.JUMP_VELOCITY


func physics_tick(var delta: float):
	fsm.get_node("Walking").physics_tick(delta)
