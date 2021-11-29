extends "res://src/Entity/Enemy/Enemy.gd"

enum GrabberState {PoweredOff, Idle, Chasing}

var sound_move = preload("res://assets/sounds/sfx/Grabber_Move.mp3")
var sound_activate = preload("res://assets/sounds/sfx/Grabber_Power_On.mp3")

var current_state: int = GrabberState.PoweredOff

var energy_buffered: bool = false

func start_turn() -> void:
	match current_state:
		GrabberState.PoweredOff:
			if _board_manager.get_cell(get_current_position()).energy_level > 0:
				current_state = GrabberState.Chasing
				# Play Power on Animation?
				anim_state_machine.travel("idle")
				audio_stream.stream = sound_activate
				audio_stream.play(0)
			
		GrabberState.Chasing:
			var current_coord = get_current_position()
			var player_coord = _board_manager.get_entity_position_by_id(_turn_manager.player_entity_id)

			var player_offset = player_coord - current_coord
			if player_offset.length() == 1:
				# if the player is near by, attack the player.

				_set_anim_direction(player_offset)
				# Play atk animation
				anim_state_machine.travel("attack")

				# Reduce Player Health
				_board_manager.get_entity_node_by_id(_turn_manager.player_entity_id).take_damage(50)
				energy_buffered = true
			else:
				# Move
				# prioritize survival if ethere is no buffered energy so it doesn't get shut down?
				if not energy_buffered and _board_manager.get_cell(current_coord).energy_level == 0:
					player_coord = _get_nearby_energy_tile()

				var move_direction = _decide_movement(player_coord)
				_move(move_direction)

				if _board_manager.get_cell(get_current_position()).energy_level != 0:
					energy_buffered = true
				elif energy_buffered:
					energy_buffered = false
				else:
					current_state = GrabberState.PoweredOff
					# Play Powered off Animation
					anim_state_machine.travel("powered_off")

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

func _move(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		return

	_set_anim_direction(direction)
	move_on_map(direction)
	anim_state_machine.travel("move")
	audio_stream.stream = sound_move
	audio_stream.play()

func _set_anim_direction(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		return
	animation_tree["parameters/idle/blend_position"] = direction
	animation_tree["parameters/powered_off/blend_position"] = direction
	animation_tree["parameters/powering_off/blend_position"] = direction
	animation_tree["parameters/powering_on/blend_position"] = direction
	animation_tree["parameters/move/blend_position"] = direction
	animation_tree["parameters/attack/blend_position"] = direction

func _animation_finished() -> void:
	if current_state == GrabberState.PoweredOff:
		return 
	anim_state_machine.travel("idle")

