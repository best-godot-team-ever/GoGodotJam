# Needs to tell the turn manager he wants his turn, but since tiny wanted to change it, i havent added that fucntionality
extends Machine

var power_on : bool = false setget set_power_on

func _ready() -> void:
	pass

func set_power_on(value: bool) -> void:
	power_on = value
	

