extends Switchable

export(int) var strength := 1

onready var area := $Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for body in area.get_overlapping_bodies():
		if body is Player:
			body.take_hit(strength)