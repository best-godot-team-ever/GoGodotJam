extends "res://src/Machines_and_Triggers/Machines/Machine.gd"


func start_turn() -> void:
	match current_state:
		MachineStates.PoweredOff:
			pass
		MachineStates.PoweredOn:
			pass
