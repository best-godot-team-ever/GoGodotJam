extends MachineAndTrigger
class_name Decoration

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	machine_type = MachineType.SolidDecoration
	._initialize(board_manager, turn_manager)
