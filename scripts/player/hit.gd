extends PlayerState

const HEALTH_START := 5


var health := HEALTH_START setget set_health
onready var hud: Control = get_tree().get_nodes_in_group("hud")[0]


func _ready():
	yield(fsm, "ready")
	yield(player, "ready")
	player.animated_sprite.connect("animation_finished", self, "anim_finished")
	player.connect("hit", self, "update_health_points")
	yield(hud, "ready")
	update_health_points(0)


func enter_state():
	if player.animated_sprite.animation == "hit":
		return
	
	player.animated_sprite.play("hit")


func tick(var delta: float):
	fsm.get_node("Walking").physics_tick(delta)


func anim_finished():
	if fsm.state == self:
		fsm.set_state("Idle")


func set_health(var new: int):
	health = max(0, new)
	hud.set_health_points(health)


func update_health_points(var change: int):
	if fsm.state_name != "Hit":
		set_health(health + change)
		if health == 0:
			fsm.set_state("Dying")
		elif change < 0:
			fsm.set_state("Hit")
