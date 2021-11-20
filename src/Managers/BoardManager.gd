extends Node2D

onready var level_grid = $LevelGrid
onready var energy_grid = $EnergyGrid
onready var entity_grid = $EntityGrid

# =======================================================
#    Entity.
# =======================================================
func add_entity(entity_to_add: Node, map_position: Vector2) -> int:
    return entity_grid.add_entity(entity_to_add, map_position)

func update_entity_position(entity_id: int, map_position: Vector2) -> void:
    entity_grid.update_entity_position(entity_id, map_position)
# =======================================================
#    Energy
# =======================================================

func set_energy(map_position: Vector2, amount: int) -> void:
    energy_grid.set_energy(map_position, amount)

# =======================================================
#    Get Cell Data.
# =======================================================

func get_cell(map_position: Vector2) -> Dictionary:
    return {
        "is_in_level": is_valid_move(map_position),
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
func is_valid_move(map_position: Vector2) -> bool:
    return level_grid.get_cell(map_position.x, map_position.y) != level_grid.INVALID_CELL

# =======================================================
#    World space < --- > Map space transfer
# =======================================================

# Make the mapping function accessable from Manager
func world_to_map(world_position: Vector2) -> Vector2:
    return level_grid.world_to_map(world_position / 2)

func map_to_world(map_position: Vector2) -> Vector2:
    return level_grid.map_to_world(map_position) / 2
