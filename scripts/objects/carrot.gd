extends Node2D

const CRISPNESS := 1

onready var animation_player := $AnimationPlayer


func _ready():
	animation_player.play("hover")
	animation_player.seek(randf() * animation_player.get_animation("hover").length)


func _on_Area2D_body_entered(var body: Node2D):
	if body is Player:
		body.consume_carrot(CRISPNESS)
		queue_free()
