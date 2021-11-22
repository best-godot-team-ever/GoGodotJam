# Needs to tell the turn manager he wants his turn, but since tiny wanted to change it, i havent added that fucntionality
extends Node2D

export var _energy_trigger : int
export (Array, PackedScene) var _link_with_machines

onready var _board = get_parent().get_node("BoardManager")


func start_turn() -> void:
	var _energy : int = _board.get_cell(_board.world_to_map(position))["energy_level"]
	if _energy >= _energy_trigger:
		power_up()
	elif _energy < _energy_trigger:
		power_down()

func power_up() -> void:
	for machine in _link_with_machines:
		machine.set_power_on(true)

func power_down() -> void:
	for machine in _link_with_machines:
		machine.set_power_on(false)





