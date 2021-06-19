extends Node2D

export var target_path: NodePath 
onready var target: Switchable = get_node(target_path)
onready var animated_sprite := $AnimatedSprite

var active: bool = false setget set_active


func set_active(var new: bool):
	active = new
	target.switch(active)
	if animated_sprite.animation == "idle":
		animated_sprite.play("activating")
		


func _on_Area2D_body_entered(body):
	if body is Player:
		set_active(!active)


func _get_configuration_warning():
	if target_path and not get_node(target_path) is Switchable:
		return "Target Node has to be an instance of Switchable!"


func _on_AnimatedSprite_animation_finished():
	animated_sprite.play("idle")
