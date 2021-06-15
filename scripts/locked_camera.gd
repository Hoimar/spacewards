extends Camera2D

const ROOM_SIZE := Vector2(320, 200) / 2
const DURATION := 1.0

export var target_path: NodePath
onready var target: Node2D = get_node(target_path)
onready var tween := $Tween


func _process(var delta: float):
	if tween.is_active():
		return
	var dist := target.global_position - global_position
	var next_pos := global_position
	if dist.x > ROOM_SIZE.x:
		next_pos.x += ROOM_SIZE.x * 2
	elif dist.x < -ROOM_SIZE.x:
		next_pos.x -= ROOM_SIZE.x * 2
	if dist.y > ROOM_SIZE.y:
		next_pos.y += ROOM_SIZE.y * 2
	elif dist.y < -ROOM_SIZE.y:
		next_pos.y -= ROOM_SIZE.y * 2
	if next_pos != global_position:
		tween.interpolate_property(self, "global_position", global_position, \
				next_pos, DURATION, Tween.TRANS_QUAD, Tween.EASE_OUT)
		tween.start()
