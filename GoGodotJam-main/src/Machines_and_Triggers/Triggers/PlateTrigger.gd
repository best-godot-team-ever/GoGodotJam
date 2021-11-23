extends "res://src/Machines_and_Triggers/Triggers/Trigger.gd"


var _is_occupied : bool = false


func start_turn() -> void:
	_is_occupied = _board_manager.is_occupied(_board_manager.world_to_map(position))
	match _is_occupied:
		true:
			power_up_machines()
			current_state = TriggerStates.Activated
		false:
			shut_down_machines()
			current_state = TriggerStates.Deactivated
