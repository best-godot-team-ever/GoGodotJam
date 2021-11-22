extends Node


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
	for key in _energy_grid.keys():
		if edited_cells.has(key):
			continue

		if _energy_grid.get(key) == 1:
			var _b = _energy_grid.erase(key)
		else:
			_energy_grid[key] = _energy_grid.get(key) - 1
	edited_cells.clear()

# =======================================================
#    The actual class, i guess.
# =======================================================

var _energy_grid: Dictionary = {}

func set_cell(map_position: Vector2, data: int) -> void:
	_energy_grid[map_position] = data

# grid data
func get_cell(map_position: Vector2) -> int:
	return _energy_grid.get(map_position, 0)

# =======================================================
