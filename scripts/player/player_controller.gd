class_name PlayerController
extends Controller


export var fsm_path: NodePath
onready var fsm: Fsm = get_node(fsm_path)
var enable_key_input: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if target.is_on_floor():
		fsm.set_state("Idle")
	target.set_facing(0)
	if enable_key_input:
		_process_input()
	
	if fsm.state_name == "Jumping":
		if target.is_on_ceiling():
			target.velocity.y = 0
		if target.velocity.y >= 0:
			fsm.set_state("Falling")


func _process_input():
	if Input.is_action_pressed("ui_up"):
		jump()
	if Input.is_action_pressed("ui_left"):
		walk(-1)
	elif Input.is_action_pressed("ui_right"):
		walk(1)


func jump():
	fsm.set_state("Jumping")


func walk(var facing: int):
	target.set_facing(facing)
	fsm.set_state("Walking")
