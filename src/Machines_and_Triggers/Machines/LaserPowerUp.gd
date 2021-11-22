extends "res://src/Machines_and_Triggers/Machines/Machine.gd"

export (String, "NorthEast", "NorthWest", "SouthEast", "SouthWest") var direction

enum LaserUpStates {PoweredOff, PoweredOn}

var current_state: int = LaserUpStates.PoweredOff
var power_on : bool = false setget set_power_on
var _laser_distance : int = 5
var _energy_ammount : int = 3
var _target_cells : Array = []


func start_turn() -> void:
	match current_state:
		LaserUpStates.PoweredOff:
			pass
		LaserUpStates.PoweredOn:
			_get_target_cells()
			_fire_laser()
			_target_cells.clear()

func _get_target_cells() -> void:
	match direction:
		"NorthEast":
			for i in _laser_distance:
				var _new_cell := Vector2(-1-i, 0) + get_current_position()
				_target_cells.append(_new_cell)
		"NorthWest":
			for i in _laser_distance:
				var _new_cell := Vector2(0, -1-i) + get_current_position()
				_target_cells.append(_new_cell)
		"SouthEast":
			for i in _laser_distance:
				var _new_cell := Vector2(0, 1+i) + get_current_position()
				_target_cells.append(_new_cell)
		"SouthWest":
			for i in _laser_distance:
				var _new_cell := Vector2(1+i, 0) + get_current_position()
				_target_cells.append(_new_cell)

func _fire_laser () -> void:
	for cell in _target_cells:
		_board_manager.energy_grid.add_energy(cell, _energy_ammount)

func set_power_on(value: bool) -> void:
	power_on = value
	if power_on == true:
		current_state = LaserUpStates.PoweredOn
	if power_on == false:
		current_state = LaserUpStates.PoweredOff
