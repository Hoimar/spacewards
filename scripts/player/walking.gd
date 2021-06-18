extends PlayerState


func enter_state():
	start_walking()
	player.animated_sprite.play("walking")


func start_walking():
	if    player.velocity.x > 0 and player.facing < 0 \
	   or player.velocity.x < 0 and player.facing > 0:
		player.velocity.x = 0   # Stop immediately to quickly turn around.


func physics_tick(var delta: float):
	player.velocity.x += Player.WALK_SPEEDUP * player.facing
