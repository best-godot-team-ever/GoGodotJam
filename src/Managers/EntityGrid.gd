extends Node

const NO_ENTITY: int = -1

var entity_counter = 1

# =======================================================
#    Adding + Removing Entity
# =======================================================

func add_entity(entity_to_add: Node, map_position: Vector2) -> int:

    # Check the location
    if _entity_position_to_id_map.has(map_position):
        return -1

    var entity_id = entity_counter
    entity_counter += 1

    _entity_id_to_position_map[entity_id] = map_position
    _entity_position_to_id_map[map_position] = entity_id

    _entity_id_to_node_map[entity_id] = entity_to_add

    return entity_id

func remove_entity(entity_id: int) -> void:
    if not _entity_id_to_position_map.has(entity_id):
        return
    
    var map_position = _entity_id_to_position_map.get(entity_id)

    var _t = _entity_id_to_position_map.erase(entity_id)
    _t = _entity_position_to_id_map.erase(map_position)
    _t = _entity_id_to_node_map.erase(entity_id)

# =======================================================
#    Get Entity Info
# =======================================================

func get_entity_position_by_id(entity_id: int) -> Vector2:
    return _entity_id_to_position_map.get(entity_id)

func get_entity_id_by_position(map_position: Vector2) -> int:
    return _entity_position_to_id_map.get(map_position, NO_ENTITY)

func get_entity_type_by_id(_entity_id: int) -> int:
    return 1

func get_entity_info_by_position(map_position: Vector2) -> Dictionary:
    var entity_id = get_entity_id_by_position(map_position)
    return {
        "entity_id": entity_id,
        "entity_type": get_entity_type_by_id(entity_id)
    }
# =======================================================
#    Updating Entity Movement
# =======================================================
func update_entity_position(entity_id: int, map_position: Vector2) -> void:
    if not _entity_id_to_position_map.has(entity_id) \
        and get_entity_id_by_position(map_position) != NO_ENTITY:

        return
    
    var old_map_position = get_entity_position_by_id(entity_id)

    _entity_id_to_position_map[entity_id] = map_position
    _entity_position_to_id_map[map_position] = entity_id

    var _t = _entity_position_to_id_map.erase(old_map_position)

# =======================================================
#    The actual class, i guess.
# =======================================================

var _entity_id_to_position_map: Dictionary = {}
var _entity_position_to_id_map: Dictionary = {}

var _entity_id_to_node_map: Dictionary = {}
# =======================================================