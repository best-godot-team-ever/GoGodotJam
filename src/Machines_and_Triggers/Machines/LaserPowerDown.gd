extends laser

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	machine_type = MachineType.LaserDown
	._initialize(board_manager, turn_manager)
	_get_target_cells()

func start_turn() -> void:
	if ! trigger_feeding_list.empty():
		_fire_laser()
		_animated_sprite.play("activated")
	if trigger_feeding_list.empty():
		_animated_sprite.play("deactivated")

func _fire_laser () -> void:
	for cell in _target_cells:
		_board_manager.energy_grid.set_energy(cell, 0)




