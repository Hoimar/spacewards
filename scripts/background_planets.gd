tool
extends Spatial

const UPDATE_FREQUENCY := 1.0

onready var sun_pivot := $SunPivot
onready var tween := $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	update_time()
	tween.interpolate_callback(self, UPDATE_FREQUENCY, "update_time")
	tween.start()


func update_time():
	var t := OS.get_time()
	var time_fraction: float = t["hour"] + t["minute"] / 60.0 + t["second"] / 3600.0
	#time_fraction = 12
	var degrees := time_fraction * 360.0 / 12.0
	sun_pivot.rotation.y = -deg2rad(degrees)
