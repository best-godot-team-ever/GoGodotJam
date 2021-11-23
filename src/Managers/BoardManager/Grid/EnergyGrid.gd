extends "res://src/Managers/BoardManager/Grid/Grid.gd"

var edited_cells = []
onready var level_grid = get_parent().get_node("LevelGrid")

# These fuctions are used to edit each individual cells
func add_energy(map_position: Vector2, amount: int) -> void:
	set_cell(map_position, get_cell(map_position) + amount)
	edited_cells.append(map_position)

func set_energy(map_position: Vector2, amount: int) -> void:
	if get_cell(map_position) < amount:
		set_cell(map_position, amount)
	edited_cells.append(map_position)
	match amount:
		0:
			level_grid.set_cell(map_position.x, map_position.y, 0)
		1:
			level_grid.set_cell(map_position.x, map_position.y, 1)
		2:
			level_grid.set_cell(map_position.x, map_position.y, 2)
		3:
			level_grid.set_cell(map_position.x, map_position.y, 3)
		4:
			level_grid.set_cell(map_position.x, map_position.y, 4)
		5:
			level_grid.set_cell(map_position.x, map_position.y, 5)

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

