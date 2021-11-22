extends Node

# =======================================================
#    The actual class, i guess.
# =======================================================

var _grid: Dictionary = {}

func set_cell(map_position: Vector2, data: int) -> void:
	_grid[map_position] = data

# grid data
func get_cell(map_position: Vector2) -> int:
	return _grid.get(map_position, 0)

# =======================================================
