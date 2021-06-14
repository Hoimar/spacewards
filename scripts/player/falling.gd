extends PlayerState


func enter_state():
	pass


func physics_tick(var delta: float):
	fsm.get_node("Walking").physics_tick(delta)
