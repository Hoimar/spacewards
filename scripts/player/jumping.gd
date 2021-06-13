extends PlayerState


func enter_state():
	if player.is_on_floor():
		player.velocity.y = Player.JUMP_VELOCITY


func tick(var delta: float):
	fsm.get_node("Walking").tick(delta)
