class_name Switchable
extends Node

var activated: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func switch():
	on_activated()


func on_activated():
	activated = true
