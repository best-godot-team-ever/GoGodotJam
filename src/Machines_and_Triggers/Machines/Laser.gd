extends Machine
class_name laser

export (String, "Right", "Left", "Up", "Down") var direction
export var _laser_distance : int = 4

var _target_cells : Array = []

func _get_target_cells() -> void:
	match direction:
		"Left":
			for i in _laser_distance:
				var _new_cell := Vector2(-1-i, 0) + _map_position
				_target_cells.append(_new_cell)
		"Up":
			for i in _laser_distance:
				var _new_cell := Vector2(0, -1-i) + _map_position
				_target_cells.append(_new_cell)
		"Down":
			for i in _laser_distance:
				var _new_cell := Vector2(0, 1+i) + _map_position
				_target_cells.append(_new_cell)
		"Right":
			for i in _laser_distance:
				var _new_cell := Vector2(1+i, 0) + _map_position
				_target_cells.append(_new_cell)
