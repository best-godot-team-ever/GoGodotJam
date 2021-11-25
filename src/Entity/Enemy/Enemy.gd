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
	