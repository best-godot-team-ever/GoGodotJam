extends Trigger

var _energy_trigger : int = 1

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	machine_type = MachineType.EnergyTrigger
	._initialize(board_manager, turn_manager)


func start_turn() -> void:
	var _energy : int = _board_manager.energy_grid.get_cell(_board_manager.world_to_map(position))
	if _energy >= _energy_trigger:
		feed_machines()
		_animated_sprite.play("activated")
	elif _energy < _energy_trigger:
		dont_feed_machines()
		_animated_sprite.play("deactivated")

