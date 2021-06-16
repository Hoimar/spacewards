extends Node2D

export var target_path: NodePath
onready var target: Switchable = get_node(target_path)

var active: bool = false setget set_active


func set_active(var new: bool):
	active = new
	target.switch(active)


func _on_Area2D_body_entered(body):
	if body is Player:
		set_active(!active)
