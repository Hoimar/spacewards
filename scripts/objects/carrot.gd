extends Node2D

const CRISPNESS := 1

onready var animation_player := $AnimationPlayer


func _ready():
	animation_player.play("hover")


func _on_Area2D_body_entered(var body: Node2D):
	if body is Player:
		print("consumed ", self)
		body.consume_carrot(CRISPNESS)
		queue_free()
