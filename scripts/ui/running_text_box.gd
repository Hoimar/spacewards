tool
extends Control

const PITCH_MIN := 0.85
const PITCH_MAX := 0.9

enum STATE {
	RUNNING_TEXT,
	WAITING,
}

signal finished

onready var tween := $Tween
onready var label := $PanelContainer/MarginContainer/LabelText
onready var sfx := $sfx
var state: int = STATE.RUNNING_TEXT
var current_part: int
var text_parts: Array


# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_children():
		if node.is_in_group("running_text_parts"):
			text_parts.append(node)
	show_next_part()


func _process(_delta):
	if Engine.is_editor_hint():
		return
	
	if Input.is_action_just_pressed("ui_accept"):
		if state == STATE.RUNNING_TEXT:
			tween.stop_all()
			label.percent_visible = 1.0
			_on_Tween_tween_completed()
		elif state == STATE.WAITING:
			show_next_part()
	if state == STATE.RUNNING_TEXT and not sfx.is_playing():
		sfx.pitch_scale = rand_range(PITCH_MIN, PITCH_MAX)
		sfx.play()


func show_next_part():
	if current_part == text_parts.size():
		emit_signal("finished")
		return
	state = STATE.RUNNING_TEXT
	var part: RunningTextPart = text_parts[current_part]

	label.percent_visible = 0.0
	label.bbcode_text = part.text
	tween.interpolate_property(label, "percent_visible", 0, 1, \
			part.text.length() / part.speed)
	tween.start()


func _on_Tween_tween_completed(_object = null, _key = null):
	state = STATE.WAITING
	current_part += 1
	sfx.stop()
