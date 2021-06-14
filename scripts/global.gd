extends Node

const GAME := preload("res://scenes/gamestates/game.tscn")
const POPUP := preload("res://scenes/gamestates/popup_menu.tscn")
const MENU := preload("res://scenes/gamestates/menu.tscn")
const SCENE_TRANSITIONER := preload("res://scenes/gamestates/scene_transitioner.tscn")

const LEVELS := "res://scenes/levels/level%d.tscn"
const CUTSCENES := "res://scenes/cutscenes/%s.tscn"

const GRAVITY := 30.0

enum STATE {
	Menu,
	Ingame,
	Won,
	Died,
	Paused,
	BackToMenu,
	Exiting,
	Transitioning,
}

var level: int = 0
var state: int = STATE.Menu
var gravity := GRAVITY

func _ready():
	set_pause_mode(Node.PAUSE_MODE_PROCESS)


func _process(_delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.set_window_fullscreen(!OS.is_window_fullscreen())


func set_state(var new):
	if new == state:
		return
	state = new
	match state:
		STATE.BackToMenu, STATE.Won:
			transition_to(MENU)
		STATE.Ingame:
			get_tree().paused = false
		STATE.Died, STATE.Won, STATE.Paused:
			get_tree().paused = true
			get_tree().get_root().add_child(POPUP.instance())
		STATE.Exiting:
			get_tree().quit()


# Either PackedScene or path to scene.
func transition_to(var target_scene):
	if state == STATE.Transitioning:
		return
	set_state(STATE.Transitioning)
	var transitioner := SCENE_TRANSITIONER.instance()
	transitioner.target_scene = target_scene
	transitioner.connect("finished", self, "_on_transition_finished")
	get_tree().get_root().add_child(transitioner)


func _on_transition_finished():
	get_tree().paused = false
	set_state(STATE.Ingame)


func play_sound(var stream: AudioStream, var pos = null):
	var asp: Node
	if pos is Vector2:
		asp = AudioStreamPlayer2D.new()
		asp.position = pos
	elif pos is Vector3:
		asp = AudioStreamPlayer3D.new()
		asp.position = pos
	else:
		asp = AudioStreamPlayer.new()
	
	asp.stream = stream
	asp.connect("finished", asp, "queue_free")
	add_child(asp)
	asp.play()
