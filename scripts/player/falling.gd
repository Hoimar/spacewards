extends PlayerState


func enter_state():
	pass


func tick(var delta: float):
	fsm.get_node("Walking").tick(delta)
