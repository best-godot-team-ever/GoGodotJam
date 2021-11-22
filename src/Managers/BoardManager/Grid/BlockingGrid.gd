extends "res://src/Managers/BoardManager/Grid/Grid.gd"

# These fuctions are used to edit each individual cells
func set_cell_is_blocking(map_position: Vector2, is_blocking: bool) -> void:
	if not is_blocking:
		# Do we wanna remove the entry if the blocking is 0?
		if _grid.has(map_position):
			var _t = _grid.erase(map_position)
		return
	
	set_cell(map_position, 1)

func get_cell_is_blocking(map_position: Vector2) -> bool:
	return true if get_cell(map_position) else false