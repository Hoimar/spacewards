extends PlayerState


func enter_state():
	if player.is_on_floor():
		player.velocity.y = Player.JUMP_VELOCITY


func physics_tick(var delta: float):
	fsm.get_node("Walking").physics_tick(delta)
