extends Switchable

onready var collision_shape := $StaticBody2D/CollisionShape2D
onready var animation_player := $AnimationPlayer


func on_activated():
	animation_player.play("open")
