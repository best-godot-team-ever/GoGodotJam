extends laser


func start_turn() -> void:
	match current_state:
		MachineStates.Deactivated:
			pass
		MachineStates.Activated:
			_get_target_cells()
			_fire_laser()
			_target_cells.clear()

func _fire_laser () -> void:
	for cell in _target_cells:
		_board_manager.energy_grid.set_energy(cell, 0)




