extends Node2D

export var _energy_trigger : int
export (Array, PackedScene) var _link_with_machines
export var turn_speed : int = 0

enum EnergyTriggerStates {Activated, Deactivated}

onready var _board_manager = get_parent().get_node("BoardManager")


func start_turn() -> void:
	# var _energy : int = _board.get_cell(_board.world_to_map(position))["energy_level"]
	var _energy : int = _board_manager.energy_grid.get_cell(_board_manager.world_to_map(position))
	if _energy >= _energy_trigger:
		power_up_machines()
	elif _energy < _energy_trigger:
		power_down_machines()

func power_up_machines() -> void:
	for machine in _link_with_machines:
		machine.set_power_on(true)

func power_down_machines() -> void:
	for machine in _link_with_machines:
		machine.set_power_on(false)





