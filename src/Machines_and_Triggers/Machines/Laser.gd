extends Machines
class_name laser

export (String, "NorthEast", "NorthWest", "SouthEast", "SouthWest") var direction

var _laser_distance : int = 4
var _target_cells : Array = []

func _get_target_cells() -> void:
	match direction:
		"NorthEast":
			for i in _laser_distance:
				var _new_cell := Vector2(-1-i, 0) + _map_position
				_target_cells.append(_new_cell)
		"NorthWest":
			for i in _laser_distance:
				var _new_cell := Vector2(0, -1-i) + _map_position
				_target_cells.append(_new_cell)
		"SouthEast":
			for i in _laser_distance:
				var _new_cell := Vector2(0, 1+i) + _map_position
				_target_cells.append(_new_cell)
		"SouthWest":
			for i in _laser_distance:
				var _new_cell := Vector2(1+i, 0) + _map_position
				_target_cells.append(_new_cell)
