class_name TheWorld
extends Node2D

onready var rooms := $Ship/Rooms
var current_room: Node setget set_current_room


func _ready():
	Global.connect("restart_room", self, "reset_room", [], CONNECT_DEFERRED)


func reset_room():
	yield(get_tree(), "idle_frame")
	var room_scene: PackedScene = load(current_room.filename)   # No lag, as scene was already loaded before.
	var new_room = room_scene.instance()
	new_room.position = current_room.position
	rooms.remove_child(current_room)
	rooms.add_child(new_room)


func set_current_room(var new: Node):
	current_room = new
