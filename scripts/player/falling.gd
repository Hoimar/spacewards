extends PlayerState


func enter_state():
	player.animated_sprite.play("falling")


func physics_tick(var delta: float):
	fsm.get_node("Walking").physics_tick(delta)
