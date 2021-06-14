extends Control


onready var label_boost_count := $MarginContainer/VBoxContainer/HBoxContainer/LabelBoostCount


func set_boosts_count(var new):
	label_boost_count.text = str(new)
