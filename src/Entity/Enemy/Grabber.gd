extends "res://src/Entity/Enemy/Enemy.gd"

enum GrabberState {PoweredOff, Idle, Chasing}

var current_state: int = GrabberState.PoweredOff

var energy_buffered: bool = false

func start_turn() -> void:
	match current_state:
		GrabberState.PoweredOff:
			if _board_manager.get_cell(get_current_position()).energy_level > 0:
				current_state = GrabberState.Chasing
				# Play Power on Animation?
#		GrabberState.Idle:
#			if _board_manager.get_cell(get_current_position()).energy_level > 0:
#				current_state = GrabberState.Chasing
		GrabberState.Chasing:

			var player_coord = _board_manager.get_entity_position_by_id(_turn_manager.player_entity_id)

			# prioritize survival if ethere is no buffered energy so it doesn't get shut down?
			if not energy_buffered and _board_manager.get_cell(get_current_position()).energy_level == 0:
				player_coord = _get_nearby_energy_tile()

			var move_direction = _decide_movement(player_coord)
			_set_anim_direction(move_direction)
			move_on_map(move_direction)

			if _board_manager.get_cell(get_current_position()).energy_level != 0:
				energy_buffered = true
			elif energy_buffered:
				energy_buffered = false
			else:
				current_state = GrabberState.PoweredOff
				# Play Powered off Animation
	
	$Label.set_text(GrabberState.keys()[current_state])

func _get_nearby_energy_tile() -> Vector2:
	var target = get_current_position()
	var player_coord = _board_manager.get_entity_position_by_id(_turn_manager.player_entity_id)
	var dist_to_player = 100.0
	# Get all the possible tiles.
	var tile_list = _board_manager.get_cells(_get_near_cells_list(target, 1, 0))

	for key in tile_list.keys():
		var _dist = key.distance_to(player_coord)
		if tile_list.get(key).is_in_level and not tile_list.get(key).is_blocked and tile_list.get(key).energy_level > 0 and _dist < dist_to_player:
			target = key
			dist_to_player = _dist

	return target
	
func _set_anim_direction(direction: Vector2) -> void:
	# if direction == Vector2.ZERO:
	# 	return
	# animation_tree["parameters/idle/blend_position"] = direction
	# animation_tree["parameters/powered_off/blend_position"] = direction
	# animation_tree["parameters/powering_off/blend_position"] = direction
	# animation_tree["parameters/powering_up/blend_position"] = direction
	pass