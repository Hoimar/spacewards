extends PlayerState


func enter_state():
	if    player.velocity.x > 0 and player.facing < 0 \
	   or player.velocity.x < 0 and player.facing > 0:
		player.velocity.x = 0   # Stop immediately.


func tick(var delta: float):
	player.velocity.x += Player.WALK_SPEEDUP * player.facing
