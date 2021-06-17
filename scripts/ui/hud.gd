extends Control


onready var label_boost_count := $MarginContainer/VBoxContainer/HBoxBoost/LabelBoostCount
onready var label_health_points := $MarginContainer/VBoxContainer/HBoxHealth/LabelHealthPoints


func set_boosts_count(var new):
	label_boost_count.text = str(new)


func set_health_points(var new):
	label_health_points.text = str(new)
