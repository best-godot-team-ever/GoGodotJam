extends "res://src/Managers/BoardManager/Grid/Grid.gd"

var edited_cells = []

# These fuctions are used to edit each individual cells
func add_energy(map_position: Vector2, amount: int) -> void:
	set_cell(map_position, get_cell(map_position) + amount)
	edited_cells.append(map_position)

func set_energy(map_position: Vector2, amount: int) -> void:
	if get_cell(map_position) < amount:
		set_cell(map_position, amount)
	edited_cells.append(map_position)

# Function is called at the end of turn. Should automatically update energy stuff
func drain_energy() -> void:
	for key in _grid.keys():
		if edited_cells.has(key):
			continue

		if _grid.get(key) == 1:
			var _b = _grid.erase(key)
		else:
			_grid[key] = _grid.get(key) - 1
	edited_cells.clear()

