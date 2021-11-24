extends Trigger


var _is_occupied : bool = false

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	machine_type = MachineType.PlateTrigger
	._initialize(board_manager, turn_manager)

func start_turn() -> void:
	_is_occupied = _board_manager.get_cell(_board_manager.world_to_map(position)).is_blocked
	match _is_occupied:
		true:
			feed_machines()
			_animated_sprite.play("activated")
		false:
			dont_feed_machines()
			_animated_sprite.play("deactivated")
