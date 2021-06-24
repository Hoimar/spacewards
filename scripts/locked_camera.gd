extends Camera2D

const ROOM_SIZE := Vector2(320, 200)
const ROOM_HALF_SIZE := ROOM_SIZE / 2
const DURATION := 0.6

export var target_path: NodePath
onready var target: Node2D = get_node(target_path)
onready var tween := $Tween


func _ready():
	global_position = ((target.global_position + ROOM_HALF_SIZE) / ROOM_SIZE).floor() * ROOM_SIZE


func _process(_delta):
	if tween.is_active():
		return
	# Try to reacquire the new player.
	if not target:
		var nodes := get_tree().get_nodes_in_group("player")
		if nodes.empty():
			return
		target = nodes[0]
	elif not target.is_inside_tree():
		target = null   # Unreference target.
		return
	
	var dist := target.global_position - global_position
	var next_pos := global_position
	if dist.x > ROOM_HALF_SIZE.x:
		next_pos.x += ROOM_SIZE.x
	elif dist.x < -ROOM_HALF_SIZE.x:
		next_pos.x -= ROOM_SIZE.x
	if dist.y > ROOM_HALF_SIZE.y:
		next_pos.y += ROOM_SIZE.y
	elif dist.y < -ROOM_HALF_SIZE.y:
		next_pos.y -= ROOM_SIZE.y
	if next_pos != global_position:
		tween.interpolate_property(self, "global_position", global_position, \
				next_pos, DURATION, Tween.TRANS_QUAD, Tween.EASE_OUT)
		tween.start()
