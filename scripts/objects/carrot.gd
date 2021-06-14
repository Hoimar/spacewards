extends Node2D

const CRISPNESS := 1


func _on_Area2D_body_entered(var body: Node2D):
	if body is Player:
		body.consume_carrot(CRISPNESS)
		queue_free()
