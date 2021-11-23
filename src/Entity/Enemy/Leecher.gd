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
				anim_state_machine.travel("idle")
		LeecherStates.Idle:
			if _board_manager.get_cell(get_current_position()).energy_level > 0:
				current_state = LeecherStates.Following
		LeecherStates.Following:
			var _next_location = _get_next_target_coord()
			var move_direction = _decide_movement(_next_location - get_current_position())
			_set_anim_direction(move_direction)
			move_on_map(move_direction)
			if _board_manager.get_cell(get_current_position()).energy_level == 0:
				current_state = LeecherStates.PoweredOff
				anim_state_machine.travel("powered_off")
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

# I got no idea so I am gonna use Felipe's code
func _decide_movement(energy_coordinate: Vector2) -> Vector2:
		# Decide movement:
		var energy_direction = Vector2(0,0)
		var coord_x_uni = Vector2(0,0)
		var coord_y_uni = Vector2(0,0)
		# Un-dimensionalization:
		if energy_coordinate.x != 0:
			coord_x_uni = Vector2(energy_coordinate.x/abs(energy_coordinate.x),0)
		if energy_coordinate.y != 0:
			coord_y_uni = Vector2(0, energy_coordinate.y/abs(energy_coordinate.y))
	
		if abs(energy_coordinate.x) == abs(energy_coordinate.y):
			# moves randorly but in the correct direction
			if randi() % 2:
				energy_direction = coord_x_uni
			else:
				energy_direction = coord_y_uni
		elif abs(energy_coordinate.x) > abs(energy_coordinate.y):
			# moves horizontaly
			energy_direction = coord_x_uni
		else:
			# moves vertically
			energy_direction = coord_y_uni
		return energy_direction

# Too faking tired to try and figure out a pretty solution. Hard code it is
func _get_near_cells_list(coord: Vector2, radius: int = 1) -> Array:
	var list = []
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			list.append(Vector2(coord.x + x, coord.y + y))
	return list

func _set_anim_direction(direction: Vector2) -> void:
	animation_tree["parameters/idle/blend_position"] = direction
	animation_tree["parameters/powered_off/blend_position"] = direction
	animation_tree["parameters/powering_off/blend_position"] = direction
	animation_tree["parameters/powering_up/blend_position"] = direction
