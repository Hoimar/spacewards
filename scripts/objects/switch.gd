extends Node2D

export var target_path: NodePath 
onready var target: Switchable = get_node(target_path)
onready var animated_sprite := $AnimatedSprite

var activated: bool


func activate():
	if activated:
		return
	activated = true
	target.switch()
	if animated_sprite.animation == "idle":
		animated_sprite.play("activating")
		


func _on_Area2D_body_entered(body):
	if body is Player:
		activate()


func _get_configuration_warning():
	if target_path and not get_node(target_path) is Switchable:
		return "Target Node has to be an instance of Switchable!"
