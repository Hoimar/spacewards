class_name TheWorld
extends Node2D

onready var ship := $Ship
onready var rooms := $Ship/Rooms
var current_room: Node setget set_current_room
onready var player: Node2D = get_tree().get_nodes_in_group("player")[0]
onready var player_enter_state = {
	"position": player.global_position,
	"facing": player.facing,
	"boosts"  : player.get_boosts(),
}

func _ready():
	Global.connect("restart_room", self, "reset_room")


func reset_room():
	ship.remove_child(player)
	rooms.remove_child(current_room)
	# Re-add room.
	var room_scene: PackedScene = load(current_room.filename)   # No lag, as scene was already loaded before.
	var new_room = room_scene.instance()
	new_room.position = current_room.position
	rooms.add_child(new_room)
	# Re-add player.
	var player_scene := load(player.filename)
	player = player_scene.instance()
	player.global_position = player_enter_state["position"]
	ship.add_child(player)
	ship.move_child(player, rooms.get_index() + 1)
	yield(player, "ready")
	player.set_facing(player_enter_state["facing"])
	player.set_boosts(player_enter_state["boosts"])


func set_current_room(var new: Node):
	current_room = new
	player_enter_state["position"] = player.global_position
	player_enter_state["facing"] = player.facing
	player_enter_state["boosts"] = player.get_boosts()
