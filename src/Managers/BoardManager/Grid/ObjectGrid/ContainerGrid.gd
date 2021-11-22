extends Node

const INVALID_ID = 0

onready var _blocking_grid: Node = $BlockingGrid

var id_counter = 1

# =======================================================
#    The actual class, i guess.
# =======================================================

var _id_to_position_map: Dictionary = {}
var _position_to_id_map: Dictionary = {}

var _id_to_node_map: Dictionary = {}

# =======================================================
#    Adding + Removing
# =======================================================
func add(object_to_add: Node, map_position: Vector2) -> int:
    if _position_to_id_map.has(map_position):
        return INVALID_ID

    var id = id_counter
    id_counter += 1

    _id_to_position_map[id] = map_position
    _position_to_id_map[map_position] = id

    _id_to_node_map[id] = object_to_add

    return id

func remove(id: int) -> void:
    if not _id_to_position_map.has(id):
        return
    
    var map_position = _id_to_position_map.get(id)

    var _t = _id_to_position_map.erase(id)
    _t = _position_to_id_map.erase(map_position)
    _t = _id_to_node_map.erase(id)

# =======================================================
#    Get Cell Info
# =======================================================

func get_position_by_id(id: int) -> Vector2:
    return _id_to_position_map.get(id)

func get_id_by_position(map_position: Vector2) -> int:
    return _position_to_id_map.get(map_position, INVALID_ID)

func get_node_by_id(id: int) -> Node:
    return _id_to_node_map.get(id)

func get_position_is_blocked(map_position) -> bool:
    return _blocking_grid.get_cell_is_blocking(map_position)
# =======================================================
