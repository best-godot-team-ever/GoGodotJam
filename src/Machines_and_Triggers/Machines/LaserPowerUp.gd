extends laser

export (String, "set_energy", "add_energy") var type = "add_energy"
export var _energy_ammount : int = 3

var _powered := false

onready var _anim_player : AnimationPlayer = $AnimationPlayer
onready var _laser_bream : RayCast2D = $LaserBeam

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	machine_type = MachineType.LaserUp
	._initialize(board_manager, turn_manager)
	_get_target_cells()
	match direction:
					"Left":
						_anim_player.play("powering_down_left")
					"Up":
						_anim_player.play("powering_down_up")
					"Down":
						_anim_player.play("powering_down_down")
					"Right":
						_anim_player.play("powering_down_right")

func start_turn() -> void:
		if ! trigger_feeding_list.empty():
			_fire_laser()
			if _powered == false:
				_powered = true
				match direction:
					"Left":
						_anim_player.play("powering_up_left")
					"Up":
						_anim_player.play("powering_up_up")
					"Down":
						_anim_player.play("powering_up_down")
					"Right":
						_anim_player.play("powering_up_right")

		if trigger_feeding_list.empty():
			if _powered == true:
				_powered = false
				match direction:
					"Left":
						_anim_player.play("powering_down_left")
					"Up":
						_anim_player.play("powering_down_up")
					"Down":
						_anim_player.play("powering_down_down")
					"Right":
						_anim_player.play("powering_down_right")

func _fire_laser () -> void:
	for cell in _target_cells:
		if type == "add_energy":
			_board_manager.energy_grid.add_energy(cell, _energy_ammount)
		elif type == "set_energy":
			_board_manager.energy_grid.set_energy(cell, _energy_ammount)




