extends PlayerState

const HEALTH_START := 5


var health := HEALTH_START
onready var hud: Control = get_tree().get_nodes_in_group("hud")[0]


func _ready():
	yield(fsm, "ready")
	yield(player, "ready")
	player.animated_sprite.connect("animation_finished", self, "anim_finished")


func enter_state():
	if player.animated_sprite.animation == "hit":
		fsm.set_state(fsm.prev_state_name)
		return
	
	player.animated_sprite.play("hit")


func tick(var delta: float):
	fsm.get_node("Walking").physics_tick(delta)


func anim_finished():
	if fsm.state == self:
		fsm.set_state("Idle")


func update_health_points(var change: int):
	health += change
	hud.set_health_points(health)
