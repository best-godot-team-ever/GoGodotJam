# Needs to tell the turn manager he wants his turn, but since tiny wanted to change it, i havent added that fucntionality
extends Node2D

export (Array, PackedScene) var _link_with_machines

onready var _board = get_parent().get_node("BoardManager")


func start_turn() -> void:
	var _is_ocupied : bool = _board.is_occupied(_board.world_to_map(position))
	if _is_ocupied:
		power_up()
	elif !_is_ocupied:
		power_down()

func power_up() -> void:
	for machine in _link_with_machines:
		machine.set_power_on(true)

func power_down() -> void:
	for machine in _link_with_machines:
		machine.set_power_on(false)



