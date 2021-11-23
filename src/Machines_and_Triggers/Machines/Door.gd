extends Machines

var opened : bool = false

func start_turn() -> void:
	match current_state:
		MachineStates.PoweredOff:
			if opened:
				_board_manager.set_machine_blocking(_board_manager.add_machine(self, _map_position), true)
				opened = false
		MachineStates.PoweredOn:
			if !opened:
				_board_manager.set_machine_blocking(_board_manager.add_machine(self, _map_position), false)
				opened = true
