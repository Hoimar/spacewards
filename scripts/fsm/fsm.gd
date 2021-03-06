class_name Fsm
extends Node

export var _target_path: NodePath
onready var target := get_node("..")
var state: State
var state_name: String setget set_state
var prev_state_name: String


# Called when the node enters the scene tree for the first time.
func _ready():
	state = get_children()[0]
	state_name = state.name


func _process(delta):
	state.tick(delta)


func _physics_process(delta):
	state.physics_tick(delta)


func set_state(var name: String):
	if state_name == name:
		return
	for state_node in get_children():
		if name.nocasecmp_to(state_node.name) == 0:
			state.leave_state()
			state = state_node
			prev_state_name = state_name
			state_name = name
			state.enter_state()
			break
