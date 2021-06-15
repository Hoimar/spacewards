extends PlayerState

func _ready():
	yield(fsm, "ready")
	yield(player, "ready")
	player.animated_sprite.connect("animation_finished", self, "anim_finished")


func enter_state():
	player.animated_sprite.play("landing")


func tick(var delta: float):
	fsm.get_node("Walking").physics_tick(delta)


func anim_finished():
	if fsm.state == self:
		fsm.set_state("Walking")
