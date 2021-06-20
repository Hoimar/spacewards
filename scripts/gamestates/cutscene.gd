extends Control

const AMPLITUDE := 30.0

onready var ship := $ShipSprite
onready var animation_player := $AnimationPlayer
onready var ship_pos_start: Vector2 = ship.rect_position
var noise: OpenSimplexNoise
var time: float

func _ready():
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 4
	noise.period = 5
	noise.persistence = 0.8
	animation_player.play("scroll_stars")


func _process(delta):
	ship.rect_position.y = ship_pos_start.y \
			+ sin(time * 2.0) * AMPLITUDE
	time += delta


func _on_RunningTextBox_finished():
	end_cutscene()


func _on_LinkButton_pressed():
	end_cutscene()


func end_cutscene():
	if filename.find("ending") == -1:
		Global.set_state(Global.STATE.StartGame)
	else:
		Global.set_state(Global.STATE.BackToMenu)
