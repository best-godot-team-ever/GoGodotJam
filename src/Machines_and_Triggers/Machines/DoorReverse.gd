extends Machine


func _initialize(board_manager: Node, turn_manager: Node) -> void:
	machine_type = MachineType.DoorReverse
	._initialize(board_manager, turn_manager)

func start_turn() -> void:
	if ! trigger_feeding_list.empty():
		_board_manager.set_machine_blocking(machine_id, true)
		_animated_sprite.play("deactivated")
	if trigger_feeding_list.empty():
		_board_manager.set_machine_blocking(machine_id, false)
		_animated_sprite.play("activated")

