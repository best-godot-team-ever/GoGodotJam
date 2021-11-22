extends "res://src/Machines_and_Triggers/Machines/Machine.gd"


enum DoorStates {PoweredOff, PoweredOn}

var current_state: int = DoorStates.PoweredOff
var power_on : bool = false setget set_power_on

func start_turn() -> void:
	match current_state:
		DoorStates.PoweredOff:
			pass
		DoorStates.PoweredOn:
			pass

func set_power_on(value: bool) -> void:
	power_on = value
	if power_on == true:
		current_state = DoorStates.PoweredOn
	if power_on == false:
		current_state = DoorStates.PoweredOff
	

