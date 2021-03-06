extends laser


onready var _anim_player : AnimationPlayer = $AnimationPlayer


func _initialize(board_manager: Node, turn_manager: Node) -> void:
	machine_type = MachineType.LaserDown
	._initialize(board_manager, turn_manager)
	_get_target_cells()

func start_turn() -> void:
	if ! trigger_feeding_list.empty():
		_fire_laser()
		_anim_player.play("powering_up_right")
	if trigger_feeding_list.empty():
		_anim_player.play("powering_down_right")

func _fire_laser () -> void:
	for cell in _target_cells:
		_board_manager.energy_grid.set_energy(cell, 0)




