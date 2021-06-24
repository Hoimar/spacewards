extends HSlider

export var bus_name: String
var _bus_index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	if bus_name:
		_bus_index = AudioServer.get_bus_index(bus_name)
		value = db2linear(AudioServer.get_bus_volume_db(_bus_index))


func _on_AudioSlider_value_changed(value):
	AudioServer.set_bus_volume_db(_bus_index, linear2db(value))
