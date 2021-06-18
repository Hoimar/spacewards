class_name Player
extends KinematicBody2D

signal carrot_consumed(crispness)
signal hit(health_change)

const WALK_FRICTION    := 0.82
const WALK_SPEEDUP     := 10.0
const WALKING_TRESHOLD := 1.0   # How slow player may be before stopping.
const JUMP_VELOCITY    := -300.0
const MAX_SPEED_X      := 100.0
const MAX_FALL_SPEED   := 300.0

onready var body: Node2D = $Body
onready var animated_sprite: AnimatedSprite = $Body/AnimatedSprite
onready var jetpack_particles: CPUParticles2D = $Body/CPUParticles2D
onready var fsm: Fsm = $Fsm

var facing: int setget set_facing   # -1 or 1
var velocity := Vector2.ZERO

onready var room_enter_state = {
	"position": global_position,
	"health"  : fsm.get_node("Hit").health,
	"boosts"  : fsm.get_node("Boosting").boosts_count,
}

func _ready():
	jetpack_particles.emitting = false
	Global.connect("restart_room", self, "_on_room_restarted")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Apply gravity.
	velocity.y += Global.gravity
	# Slow down?
	if facing == 0 and abs(velocity.x) > 0:
		velocity.x *= WALK_FRICTION
		if abs(velocity.x) < WALKING_TRESHOLD:
			velocity.x = 0
	# Clamp velocity.
	velocity.x = clamp(velocity.x, -MAX_SPEED_X, MAX_SPEED_X)
	velocity.y = clamp(velocity.y, -INF, MAX_FALL_SPEED)
	move_and_slide(velocity, Vector2.UP, true)
	# Stop on floor?
	if is_on_floor():
		velocity.y = 0
	if is_on_wall():
		velocity.x = 0
	# Debug.
	#$Label.text = "%s | %s" % [fsm.state_name, velocity]


func set_facing(var new: int):
	facing = new
	if new != 0:
		body.set_scale(Vector2(new, 1))


func consume_carrot(var crispness: int):
	emit_signal("carrot_consumed", crispness)


func take_hit(var strength: int):
	emit_signal("hit", -strength)	


func on_room_entered(var room: Node):
	room_enter_state["position"] = global_position
	room_enter_state["health"] = fsm.get_node("Hit").health
	room_enter_state["boosts"] = fsm.get_node("Boosting").boosts_count


func _on_room_restarted():
	var world: TheWorld = get_tree().get_nodes_in_group("world")[0]
	global_position = room_enter_state["position"]
	fsm.set_state("Idle")
	fsm.get_node("Hit").health = room_enter_state["health"]
	fsm.get_node("Boosting").boosts_count = room_enter_state["boosts"]
	velocity = Vector2.ZERO
