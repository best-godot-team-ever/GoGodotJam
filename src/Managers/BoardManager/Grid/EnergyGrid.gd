extends "res://src/Managers/BoardManager/Grid/Grid.gd"

onready var level_grid = get_parent().get_node("LevelGrid")
var edited_cells = []
onready var level_grid = get_parent().get_node("LevelGrid")

# These fuctions are used to edit each individual cells
func add_energy(map_position: Vector2, amount: int) -> void:
	set_energy(map_position, get_cell(map_position) + amount)
	edited_cells.append(map_position)

func set_energy_up_to_amount(map_position: Vector2, amount: int) -> void:
	if get_cell(map_position) < amount:
		set_energy(map_position, amount)
	edited_cells.append(map_position)
	level_grid.set_cell(map_position.x, map_position.y, amount)
		

# Function is called at the end of turn. Should automatically update energy stuff
func drain_energy() -> void:
	for key in _grid.keys():
		if edited_cells.has(key):
			continue

		set_energy(key, get_cell(key) - 1)
	edited_cells.clear()


func set_energy(map_position: Vector2, amount: int) -> void:

	if amount == 0:
		var _b = _grid.erase(map_position)
	else:
		_grid[map_position] = amount

	# Update the tile
	level_grid.set_cell(map_position.x, map_position.y, amount if amount <= 5 else 5)

	pass