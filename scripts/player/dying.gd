extends PlayerState


func _ready():
	yield(fsm, "ready")
	yield(player, "ready")
	player.animated_sprite.connect("animation_finished", self, "anim_finished")
	player.connect("hit", fsm, "set_state", ["Dying"])


func enter_state():
	Global.play_sound(get_node("sfx").stream)
	player.animated_sprite.play("dying")


func anim_finished():
	if fsm.state == self:
		Global.set_state(Global.STATE.Died)
