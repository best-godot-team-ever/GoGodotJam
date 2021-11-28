extends "res://src/Managers/BoardManager/Grid/Grid.gd"

var edited_cells = []

onready var level_grid = get_parent().get_node("LevelGrid")
onready var number_grid = get_parent().get_node("NumberGrid")
onready var number_grid_big = get_parent().get_node("NumberGridBig")


# These fuctions are used to edit each individual cells
func add_energy(map_position: Vector2, amount: int) -> void:
	set_energy(map_position, get_cell(map_position) + amount)
	edited_cells.append(map_position)

func set_energy_up_to_amount(map_position: Vector2, amount: int) -> void:
	if get_cell(map_position) < amount:
		set_energy(map_position, _min(amount, 5))
	edited_cells.append(map_position)		

func reduce_energy(map_position: Vector2, amount: int) -> void:
	var value: int = get_cell(map_position) - amount
	set_energy(map_position, 0 if value < 0 else value)
	edited_cells.append(map_position)

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

	# Update the tile. 
	level_grid.set_cell(map_position.x, map_position.y, amount if amount <= 5 else 5)
	number_grid.set_cell(map_position.x, map_position.y, amount if amount <= 5 else 5)
	number_grid_big.set_cell(map_position.x, map_position.y, amount if amount <= 5 else 5)


	pass

func _min(a: int, b: int) -> int:
	return a if a < b else b