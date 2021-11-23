extends laser

export (String, "set_energy", "add_energy") var type = "add_energy"
export var _energy_ammount : int = 3


func start_turn() -> void:
	match current_state:
		MachineStates.Activated:
			pass
		MachineStates.Deactivated:
			_get_target_cells()
			_fire_laser()
			_target_cells.clear()

func _fire_laser () -> void:
	for cell in _target_cells:
		if type == "add_energy":
			_board_manager.energy_grid.add_energy(cell, _energy_ammount)
		elif type == "set_energy":
			_board_manager.energy_grid.set_energy(cell, _energy_ammount)
