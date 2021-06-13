extends State

onready var player: Player = get_parent().target
var animated_sprite: AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(player, "ready")
	animated_sprite = player.animated_sprite


func enter_state():
	animated_sprite.play("idle")


func tick(var delta: float):
	pass
