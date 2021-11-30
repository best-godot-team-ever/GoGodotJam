extends Machine


func _initialize(board_manager: Node, turn_manager: Node) -> void:
	machine_type = MachineType.DoorReverse
	._initialize(board_manager, turn_manager)

func start_turn() -> void:
	if ! trigger_feeding_list.empty():
		_board_manager.set_machine_blocking(machine_id, true)
		if !_board_manager.is_blocked_by_entity(_board_manager.world_to_map(position)):
			_animated_sprite.play("deactivated")
	if trigger_feeding_list.empty():
		_board_manager.set_machine_blocking(machine_id, false)
		_animated_sprite.play("activated")

