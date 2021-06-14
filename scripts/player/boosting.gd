extends PlayerState

const BOOST_STRENGTH := 36.0
const BOOST_DURATION := 0.7
const BOOSTS_START   := 2

var boost_time := 0.0
var boosts_count := BOOSTS_START
onready var hud: Control = get_tree().get_nodes_in_group("hud")[0]


func _ready():
	yield(fsm, "ready")
	player.connect("carrot_consumed", self, "update_boost")


func enter_state():
	if boosts_count == 0:
		fsm.set_state("Falling")
	else:
		boost_time = 0
		update_boost(-1)


func physics_tick(var delta: float):
	boost_time += delta
	player.velocity.y -= BOOST_STRENGTH
	if boost_time >= BOOST_DURATION:
		fsm.set_state("Falling")
	fsm.get_node("Walking").physics_tick(delta)


func update_boost(var change: int):
	boosts_count += change
	hud.set_boosts_count(boosts_count)
