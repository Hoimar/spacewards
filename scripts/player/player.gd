class_name Player
extends KinematicBody2D

const WALK_FRICTION  := 0.82
const WALK_SPEEDUP   := 10.0
const JUMP_VELOCITY  := -450.0
const MAX_SPEED_X    := 100.0
const MAX_FALL_SPEED := 300.0

onready var animated_sprite: AnimatedSprite = $Body/AnimatedSprite
onready var body: Node2D = $Body
onready var fsm: Fsm = $Fsm

var facing: int setget set_facing   # -1 or 1
var velocity := Vector2.ZERO
var _is_carrying := false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Apply gravity.
	velocity.y += Global.gravity
	# Slow down?
	if fsm.state_name != "Walking" and abs(velocity.x) > 0:
		velocity.x *= WALK_FRICTION
		if abs(velocity.x) < 1.0:
			velocity.x = 0
	# Clamp velocity.
	velocity.x = clamp(velocity.x, -MAX_SPEED_X, MAX_SPEED_X)
	velocity.y = clamp(velocity.y, -INF, MAX_FALL_SPEED)
	move_and_slide(velocity, Vector2.UP, true)
	# Stop on floor?
	if is_on_floor():
		velocity.y = 0
	# Debug.
	$Label.text = "%s | %s" % [fsm.state_name, velocity]


func set_facing(var new: int):
	facing = new
	if new != 0:
		body.set_scale(Vector2(new, 1))
