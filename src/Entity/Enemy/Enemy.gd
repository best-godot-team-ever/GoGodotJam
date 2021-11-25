extends "res://src/Entity/Entity.gd"

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	._initialize(board_manager, turn_manager)
	_turn_manager.subscribe_enemy(self)

func _get_near_cells_list(coord: Vector2, radius: int = 1, padding: float = 0.5) -> Array:
	var list = []
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			var target = Vector2(coord.x + x, coord.y + y)
			if coord.distance_to(target) <= radius + padding:
				list.append(target)
	return list

func _decide_movement(target_coord: Vector2) -> Vector2:
	var current_position = get_current_position()
	var next_move = current_position
	
	# Check Each of the 4 directions around me. If It's a valid tile and the tile will bring me closer to the target coord, take it.
	var next_move_dist = current_position.distance_to(target_coord)
	var possible_moves = _board_manager.get_cells(_get_near_cells_list(current_position, 1, 0))
	for move in possible_moves.keys():
		if not possible_moves.get(move).is_in_level or possible_moves.get(move).is_blocked:
			continue
		var dist = move.distance_to(target_coord)
		if dist < next_move_dist:
			next_move_dist = dist
			next_move = move

	return next_move - current_position
