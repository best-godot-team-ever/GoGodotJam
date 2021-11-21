extends Node2D

# Reference of board manager
onready var board_manager = get_parent().get_node("BoardManager")
var current_coord

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Takes initial position and places in grid
	var initial_coord = board_manager.world_to_map(position)
	# Place character in the grid
	position = board_manager.map_to_world(initial_coord)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func initiate_turn():
	pass
