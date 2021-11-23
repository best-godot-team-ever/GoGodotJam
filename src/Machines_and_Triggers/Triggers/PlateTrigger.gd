extends "res://src/Machines_and_Triggers/Triggers/Trigger.gd"


var _is_occupied : bool = false


func start_turn() -> void:
	_is_occupied = _board_manager.get_cell(_board_manager.world_to_map(position)).is_blocked
	match _is_occupied:
		true:
			power_up_machines()
			current_state = MachineStates.Activated
		false:
			shut_down_machines()
			current_state = MachineStates.Deactivated
