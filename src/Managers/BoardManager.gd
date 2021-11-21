extends Node2D

onready var levelGrid = $LevelGrid

<<<<<<< Updated upstream
var entity_mapping = {}
var entity_counter = 1

func add_entity(entity_to_add: Node, _map_position: Vector2) -> bool:
    # if not entityGrid.is_valid_move(_map_position):
    #    return false

    # entityGrid.set(entity_counter, _map_position)
    # entity_to_add.set_grid_id(entity_counter)

    entity_mapping[entity_counter] = entity_to_add
    entity_counter += 1
=======
# =======================================================
#    Entity.
# =======================================================
func add_entity(entity_to_add: Node, map_position: Vector2) -> int:
	if not is_in_level(map_position):
		return -1
	
	return entity_grid.add_entity(entity_to_add, map_position)

func update_entity_position(entity_id: int, map_position: Vector2) -> void:
	if not is_in_level(map_position):
		return
	
	entity_grid.update_entity_position(entity_id, map_position)
# =======================================================
#    Energy
# =======================================================

func set_energy(map_position: Vector2, amount: int) -> void:
	if not is_in_level(map_position):
		return
	
	energy_grid.set_energy(map_position, amount)

func drain_energy() -> void:
	energy_grid.drain_energy()
>>>>>>> Stashed changes

    return true

<<<<<<< Updated upstream

# Get Cell Data
func get_cell_data(map_position: Vector2) -> Dictionary:
    return {
        "is_valid_move": is_valid_move(map_position),
        "energy_level": 0,
        "has_player": false,
        "has_enemy": false,
        "object_list": {},
    }

# Is the cell occupied / Can you move to cell.
# Maybe add an another check for enemies
func is_valid_move(map_position: Vector2) -> bool:
    return levelGrid.get_cell(map_position.x, map_position.y) != levelGrid.INVALID_CELL

# Make the mapping function accessable from Manager
func world_to_map(world_position: Vector2) -> Vector2:
    return levelGrid.world_to_map(world_position / 2)

func map_to_world(map_position: Vector2) -> Vector2:
    return levelGrid.map_to_world(map_position) / 2

# Get the max dimention of the level to set up a grid?
# Maybe just use a look up dictionary instead?!?
=======
func get_cell(map_position: Vector2) -> Dictionary:
	return {
		"is_in_level": is_in_level(map_position),
		"is_occupied": is_occupied(map_position),
		"energy_level": energy_grid.get_cell(map_position),
		"entity_info": entity_grid.get_entity_info_by_position(map_position)
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

func is_occupied(map_position: Vector2) -> bool:
	return entity_grid.get_entity_info_by_position(map_position).get("entity_id", -1) != entity_grid.NO_ENTITY

# =======================================================
#    World space < --- > Map space transfer
# =======================================================

# Make the mapping function accessable from Manager
func world_to_map(world_position: Vector2) -> Vector2:
	return level_grid.world_to_map(level_grid.to_local(world_position))

func map_to_world(map_position: Vector2) -> Vector2:
	return level_grid.map_to_world(map_position) / 2
>>>>>>> Stashed changes
