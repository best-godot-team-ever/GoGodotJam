extends "res://src/Machines_and_Triggers/Triggers/Trigger.gd"

export var _energy_trigger : int


func start_turn() -> void:
	var _energy : int = _board_manager.energy_grid.get_cell(_board_manager.world_to_map(position))
	if _energy >= _energy_trigger:
		power_up_machines()
		current_state = TriggerStates.Activated
	elif _energy < _energy_trigger:
		shut_down_machines()
		current_state = TriggerStates.Deactivated
