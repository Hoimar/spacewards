extends Switchable


onready var area := $Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for body in area.get_overlapping_bodies():
		if body is Player:
			body.take_hit()
