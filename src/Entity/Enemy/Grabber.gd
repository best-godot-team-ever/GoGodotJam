extends "res://src/Entity/Enemy/Enemy.gd"

enum GrabberState {PoweredOff, Idle, Chasing}

var current_state: int = GrabberState.PoweredOff

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
			if _board_manager.get_cell(get_current_position()).energy_level == 0:
				current_state = GrabberState.PoweredOff
				# Play Powered off Animation

			else:
				# I have power so I should move one tile towards the player's current position
				_move_towards_player()
	$Label.set_text(GrabberState.keys()[current_state])

func _move_towards_player() -> void:
	var player_coord = _board_manager.get_entity_position_by_id(_turn_manager.player_entity_id)
	var offset = player_coord - get_current_position()

	var direction = _decide_movement(offset)

	move_on_map(direction)
	
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

