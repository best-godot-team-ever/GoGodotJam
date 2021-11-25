extends "res://src/Entity/Enemy/Enemy.gd"

enum LeecherStates {PoweredOff, Idle, Following}

var current_state: int = LeecherStates.PoweredOff

# Start off powered off.
# When it wakes up, it sucks all energy from the tile?
#
const MAX_ENERGY: int = 3

var stored_energy: int = 0

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
			
			# Suck Energy.
			_suck_energy()
		LeecherStates.Following:

			var target_coord = _get_next_target_coord()
			var move_direction = _decide_movement(target_coord)
			_set_anim_direction(move_direction)
			move_on_map(move_direction)

			# Suck Energy.
			_suck_energy()


			if _board_manager.get_cell(get_current_position()).energy_level == 0 and stored_energy == 0:
				current_state = LeecherStates.PoweredOff
				anim_state_machine.travel("powered_off")
			# 	# Play Powered off Animation
	$Label.set_text(LeecherStates.keys()[current_state])

func _suck_energy() -> void:
	# the tile that it's on...
	var _tile_energy = _board_manager.get_cell(get_current_position()).energy_level
	if _tile_energy == 0:
		stored_energy -= 1
	else:
		stored_energy = _min(stored_energy + _tile_energy, MAX_ENERGY)
		_board_manager.reduce_energy(get_current_position(), _tile_energy)

func _get_next_target_coord() -> Vector2:
	var target = get_current_position()
	var max_energy: = 0
	# Get all the possible tiles.
	var tile_list = _board_manager.get_cells(_get_near_cells_list(target, stored_energy, 0))

	for key in tile_list.keys():
		if tile_list.get(key).is_in_level and tile_list.get(key).energy_level > max_energy:
			target = key
			max_energy = tile_list.get(key).energy_level

	return target

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

func _set_anim_direction(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		return
	animation_tree["parameters/idle/blend_position"] = direction
	animation_tree["parameters/powered_off/blend_position"] = direction
	animation_tree["parameters/powering_off/blend_position"] = direction
	animation_tree["parameters/powering_up/blend_position"] = direction

# Fk man Godot, get one for INT plz.
func _min(a: int, b: int):
	return a if a < b else b