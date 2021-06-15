class_name PlayerController
extends Controller


export var fsm_path: NodePath
onready var fsm: Fsm = get_node(fsm_path)
var enable_key_input: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	target.set_facing(0)
	
	if target.is_on_floor() and fsm.state_name == "Falling":
		fsm.set_state("Landing")
	
	if enable_key_input:
		_process_input()
	
	if     target.velocity.y > 0 \
	   and not target.is_on_floor() \
	   and fsm.state_name != "Boosting" :
		fsm.set_state("Falling")
	
	if fsm.state_name == "Jumping":
		if target.is_on_ceiling():
			target.velocity.y = 0
	elif     target.is_on_floor() \
	   and target.facing == 0 \
	   and fsm.state_name != "Boosting" \
	   and fsm.state_name != "Landing" \
	   and target.velocity.y >= 0:
			fsm.set_state("Idle")   # Allowed to idle.


func _process_input():
	if Input.is_action_pressed("ui_up"):
		jump()
	if Input.is_action_pressed("ui_left"):
		walk(-1)
	elif Input.is_action_pressed("ui_right"):
		walk(1)
	if Input.is_action_pressed("ui_select"):
		boost()


func jump():
	if    not target.is_on_floor() \
	   or fsm.state_name == "Boosting" \
	   or fsm.state_name == "Landing":
		return
	fsm.set_state("Jumping")


func boost():
	fsm.set_state("Boosting")


func walk(var facing: int):
	target.set_facing(facing)
	if    fsm.state_name == "Boosting" \
	   or fsm.state_name == "Jumping" \
	   or fsm.state_name == "Landing":
		return
	fsm.set_state("Walking")
