extends Node2D

onready var board_manager = get_parent().get_node("BoardManager")
onready var tween = $Tween
export var search_range = 3
var current_coord: Vector2
var initial_coord: Vector2


# # For testing... Put this on player... and attach signal
# signal activate_enemy_turn
# var cell = board_manager.get_cell(current_coord)
# board_manager.set_energy(current_coord, cell["energy_level"] + 10)
# emit_signal('activate_enemy_turn')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Takes initial position and places in grid
	initial_coord = board_manager.world_to_map(position)
	current_coord = initial_coord
	# Place character in the grid
	position = board_manager.map_to_world(initial_coord)


func get_max_energy(input:Vector2) -> Vector2:
	# Take energy profile around this cell
	var energy_coordinate = Vector2(0,0)
	var max_energy = 0
	for x in range(search_range * 2 + 1):
		for y in range(search_range * 2 + 1):
			var local_x = x - search_range
			var local_y = y - search_range
			if abs(local_x) + abs(local_y) <= search_range:
				var cell = board_manager.get_cell(input + Vector2(local_x, local_y))
				if cell["energy_level"] > max_energy: 
					max_energy = cell["energy_level"]
					# Energy coordinate is relative (local)
					energy_coordinate = Vector2(local_x, local_y)



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


func initiate_turn():
	# Takes tile with more energy
	var next_coord = current_coord + get_max_energy(current_coord)

	# Makes movement animation
	if board_manager.is_in_level(next_coord):
		var current_position = board_manager.map_to_world(current_coord)
		var next_position = board_manager.map_to_world(next_coord)
		tween.interpolate_property(self, "position",
			current_position, next_position, 1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		current_coord = next_coord
		tween.start()
	
	# Interacts with player if it founds player


	return
