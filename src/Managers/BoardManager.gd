extends Node2D

onready var levelGrid = $LevelGrid

var entity_mapping = {}
var entity_counter = 1

func add_entity(entity_to_add: Node, _map_position: Vector2) -> bool:
    # if not entityGrid.is_valid_move(_map_position):
    #    return false

    # entityGrid.set(entity_counter, _map_position)
    # entity_to_add.set_grid_id(entity_counter)

    entity_mapping[entity_counter] = entity_to_add
    entity_counter += 1

    return true


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
