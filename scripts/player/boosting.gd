extends PlayerState

const BOOST_STRENGTH := 35.0
const BOOST_DURATION := 0.7
const BOOSTS_START   := 1

var boost_time := 0.0
var boosts_count := BOOSTS_START setget set_boosts_count
onready var hud: Node = get_tree().get_nodes_in_group("hud")[0]


func _ready():
	yield(fsm, "ready")
	player.connect("carrot_consumed", self, "update_boost")
	set_boosts_count(boosts_count)


func enter_state():
	if boosts_count == 0:
		fsm.set_state(fsm.prev_state_name)
		return
	
	start_boosting()
	player.animated_sprite.play("boosting")


func start_boosting():
	if boosts_count == 0:
		return
	
	boost_time = 0
	update_boost(-1)
	player.jetpack_particles.emitting = true
	Global.play_sound(get_node("sfx").stream)


func physics_tick(var delta: float):
	boost_time += delta
	player.velocity.y -= BOOST_STRENGTH
	if boost_time >= BOOST_DURATION:
		fsm.set_state("Falling")
	fsm.get_node("Walking").physics_tick(delta)


func leave_state():
	player.jetpack_particles.emitting = false


func set_boosts_count(var new):
	boosts_count = new
	hud.set_boosts_count(boosts_count)


func update_boost(var change: int):
	set_boosts_count(boosts_count + change)
