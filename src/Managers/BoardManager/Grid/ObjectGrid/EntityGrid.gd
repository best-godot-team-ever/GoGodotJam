extends "res://src/Managers/BoardManager/Grid/ObjectGrid/ContainerGrid.gd"

const NO_ENTITY: int = 0

# Entites automatically set their blocking.
# =======================================================
#    Adding + Removing Entity
# =======================================================

func add_entity(entity_to_add: Node, map_position: Vector2) -> int:
	var entity_id = add(entity_to_add, map_position)
	if entity_id:
		_blocking_grid.set_cell_is_blocking(map_position, true)
	return entity_id

func remove_entity(entity_id: int) -> void:
	var map_position = get_entity_position_by_id(entity_id)
	remove(entity_id)
	_blocking_grid.set_cell_is_blocking(map_position, false)

# =======================================================
#    Get Entity Info
# =======================================================

func get_entity_position_by_id(entity_id: int) -> Vector2:
	return get_position_by_id(entity_id)

func get_entity_id_by_position(map_position: Vector2) -> int:
	return get_id_by_position(map_position)

func get_entity_node_by_id(entity_id: int) -> Node:
	return get_node_by_id(entity_id)
# =======================================================
#    Updating Entity Movement
# =======================================================
func update_entity_position(entity_id: int, map_position: Vector2) -> void:
	if not _id_to_position_map.has(entity_id) \
		and get_entity_id_by_position(map_position) != NO_ENTITY:

		return
	
	var old_map_position = get_entity_position_by_id(entity_id)

	_id_to_position_map[entity_id] = map_position
	_position_to_id_map[map_position] = entity_id

	var _t = _position_to_id_map.erase(old_map_position)

	# Update the blocking as well.
	_blocking_grid.set_cell_is_blocking(old_map_position, false)
	_blocking_grid.set_cell_is_blocking(map_position, true)

