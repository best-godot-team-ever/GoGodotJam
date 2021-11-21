extends Node2D

onready var board_manager = $BoardManager
onready var player = $Player

func _ready() -> void:

	# Currently this script doesn't do anything. I am just using to test my code in Board Manager. U can delete this.

	var cell_position = Vector2(-1, -1)
	var entity_id = board_manager.add_entity(player, cell_position)
	print(entity_id)
	board_manager.set_energy(cell_position, 5)
	board_manager.update_entity_position(entity_id, cell_position + Vector2.UP)
	print(board_manager.get_cells([cell_position, cell_position + Vector2.UP]))
	
