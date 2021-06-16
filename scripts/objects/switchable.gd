class_name Switchable
extends Node

var active: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func switch(var active: bool):
	self.active = active
