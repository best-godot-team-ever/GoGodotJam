extends "res://src/Entity/Enemy/Enemy.gd"

enum LeecherStates {PoweredOff, Idle, Following}

var current_state: int = LeecherStates.PoweredOff

# Start off powered off.
# When it wakes up, it sucks all energy from the tile?
# 

func start_turn() -> void:
	match current_state:
		LeecherStates.PoweredOff:
			if _board_manager.get_cell(get_current_position()).energy_level > 0:
				current_state = LeecherStates.Idle
				# Play Power on Animation?
		LeecherStates.Idle:
			if _board_manager.get_cell(get_current_position()).energy_level > 0:
				current_state = LeecherStates.Following
		LeecherStates.Following:
			var _next_location = _get_next_target_coord()
			move_on_map(_next_location - get_current_position())
			# if _board_manager.get_cell(get_current_position()).energy_level == 0:
			# 	current_state = PoweredOff
			# 	# Play Powered off Animation
	$Label.set_text(LeecherStates.keys()[current_state])

func _get_next_target_coord() -> Vector2:
	var target = get_current_position()
	var max_energy: = 0
	# Get all the possible tiles.
	var tile_list = _board_manager.get_cells(_get_near_cells_list(target))

	for key in tile_list.keys():
		if tile_list.get(key).is_in_level and tile_list.get(key).energy_level > max_energy:
			target = key
			max_energy = tile_list.get(key).energy_level

	return target

# Too faking tired to try and figure out a pretty solution. Hard code it is
func _get_near_cells_list(coord: Vector2, radius: int = 1) -> Array:
	var list = []
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			list.append(Vector2(coord.x + x, coord.y + y))
	return list
