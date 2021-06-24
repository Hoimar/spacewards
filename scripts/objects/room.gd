class_name Room
extends Node2D


onready var world: TheWorld = get_tree().get_nodes_in_group("world")[0]


func _on_Area2D_body_entered(body):
	if body is Player:
		world.set_current_room(self)
