extends Node2D
class_name BoardManager

var visibility : int = 0 setget set_visibility

onready var level_grid = $LevelGrid
onready var energy_grid = $EnergyGrid
onready var entity_grid = $EntityGrid
onready var machine_grid = $MachineGrid

# =======================================================
#    Entity.
# =======================================================
func add_entity(entity_to_add: Node, map_position: Vector2) -> int:
	if not is_in_level(map_position):
		return entity_grid.NO_ENTITY
	
	return entity_grid.add_entity(entity_to_add, map_position)

func update_entity_position(entity_id: int, map_position: Vector2) -> void:
	if not is_in_level(map_position):
		return
	
	entity_grid.update_entity_position(entity_id, map_position)

func get_entity_position_by_id(entity_id: int) -> Vector2:
	return entity_grid.get_entity_position_by_id(entity_id)

# =======================================================
#    Machines.
# =======================================================
func add_machine(machine_to_add: Node, map_position: Vector2) -> int:
	if not is_in_level(map_position):
		return machine_grid.NO_MACHINE

	return machine_grid.add_machine(machine_to_add, map_position)

func set_machine_blocking(machine_id, is_blocking) -> void:
	machine_grid.set_machine_blocking(machine_id, is_blocking)

# =======================================================
#    Energy
# =======================================================

func set_energy(map_position: Vector2, amount: int) -> void:
	if not is_in_level(map_position):
		return
	
	energy_grid.set_energy_up_to_amount(map_position, amount)

func drain_energy() -> void:
	energy_grid.drain_energy()

# =======================================================
#    Get Cell Data.
# =======================================================

func get_cell(map_position: Vector2) -> Dictionary:
	return {
		"is_in_level": is_in_level(map_position),
		"is_blocked": is_blocked(map_position),
		"energy_level": energy_grid.get_cell(map_position)
	}

# A mass get function
func get_cells(map_positions: Array) -> Dictionary:
	var cell_data = {}
	for position in map_positions:
		cell_data[position] = get_cell(position)
	return cell_data

# =======================================================
#    Helper
# =======================================================

# Is the cell occupied / Can you move to cell.
# Maybe add an another check for enemies
func is_in_level(map_position: Vector2) -> bool:
	return level_grid.get_cell(map_position.x, map_position.y) != level_grid.INVALID_CELL

func is_blocked(map_position: Vector2) -> bool:
	return entity_grid.get_position_is_blocked(map_position) or machine_grid.get_position_is_blocked(map_position)

# =======================================================
#    World space < --- > Map space transfer
# =======================================================

# Make the mapping function accessable from Manager
func world_to_map(world_position: Vector2) -> Vector2:
	return level_grid.world_to_map(level_grid.to_local(world_position))

func map_to_world(map_position: Vector2) -> Vector2:

	return level_grid.to_global(level_grid.map_to_world(map_position)) + Vector2(0, level_grid.cell_size.y / 2)

func set_visibility(value) -> void:
	visibility = value
	if visibility == 3:
		visibility = 0
	match visibility:
		0:
			$NumberGrid.visible = false
			$NumberGridBig.visible = false
		1:
			$NumberGrid.visible = true
			$NumberGridBig.visible = false
		2:
			$NumberGrid.visible = false
			$NumberGridBig.visible = true
