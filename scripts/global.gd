extends Node

const INTRO := preload("res://scenes/gamestates/intro.tscn")
const GAME := preload("res://scenes/gamestates/game.tscn")
const ENDING := preload("res://scenes/gamestates/ending.tscn")
const POPUP := preload("res://scenes/gamestates/popup_menu.tscn")
const MENU := preload("res://scenes/gamestates/menu.tscn")
const SCENE_TRANSITIONER := preload("res://scenes/gamestates/scene_transitioner.tscn")

const GRAVITY := 30.0

const GAME_SEQUENCE = [
	INTRO,
	GAME,
	ENDING,
]

enum STATE {
	Menu,
	Intro,
	StartGame,
	Ingame,
	Won,
	Died,
	Pause,
	BackToMenu,
	RestartRoom,
	Exiting,
	Transitioning,
}

signal restart_room

var state: int = STATE.Menu
var gravity := GRAVITY

func _ready():
	set_pause_mode(Node.PAUSE_MODE_PROCESS)
	OS.min_window_size = OS.window_size


func _process(_delta):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		OS.set_window_fullscreen(!OS.is_window_fullscreen())


func set_state(var new):
	if new == state:
		return
	state = new
	match state:
		STATE.Intro:
			get_tree().paused = true
			transition_to(INTRO)
		STATE.BackToMenu:
			get_tree().paused = true
			transition_to(MENU)
		STATE.StartGame:
			get_tree().paused = true
			transition_to(GAME)
		STATE.Won:
			get_tree().paused = true
			transition_to(ENDING)
		STATE.Ingame:
			get_tree().paused = false
		STATE.Pause:
			get_tree().paused = true
			get_tree().get_root().add_child(POPUP.instance())
		STATE.RestartRoom, STATE.Died:
			emit_signal("restart_room")
			set_state(STATE.Ingame)
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
	asp.bus = "Sound"
	asp.connect("finished", asp, "queue_free")
	add_child(asp)
	asp.play()
