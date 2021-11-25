extends Machine

var _activated := false 
export var _inverted := false

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	machine_type = MachineType.DoorChanging
	._initialize(board_manager, turn_manager)
	if _inverted:
		_activated = true
		_board_manager.set_machine_blocking(machine_id, false)
		_animated_sprite.play("activated")

func start_turn() -> void:
	if ! trigger_feeding_list.empty():
		if _activated == false:
			_activated = true
			_board_manager.set_machine_blocking(machine_id, false)
			_animated_sprite.play("activated")
		elif _activated == true:
			_activated = false
			_board_manager.set_machine_blocking(machine_id, true)
			_animated_sprite.play("deactivated")
	if trigger_feeding_list.empty():
			pass

