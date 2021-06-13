class_name PlayerState
extends State

var player: Player
var animated_sprite: AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(fsm, "ready")
	player = fsm.target
	animated_sprite = player.animated_sprite
