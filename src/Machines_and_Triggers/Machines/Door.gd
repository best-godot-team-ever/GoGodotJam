extends Machines

var opened : bool = false

func start_turn() -> void:
	match current_state:
		MachineStates.Activated:
			print("i am activated")
			if opened:
				_board_manager.set_machine_blocking(machine_id, true)
				opened = false
				print ("i closed")
				
		MachineStates.Deactivated:
			print ("i am deactivated")
			if !opened:
				_board_manager.set_machine_blocking(machine_id, false)
				opened = true
				print ("i opened")
