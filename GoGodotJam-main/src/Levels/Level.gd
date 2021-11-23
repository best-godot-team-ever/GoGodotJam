extends Node2D

# This script will pass Board Manager into every Entity class

onready var board_manager = $BoardManager
onready var turn_manager = $TurnManager

func _ready() -> void:
	turn_manager.init(board_manager)
	for entity in $Entities.get_children():
		entity.init(board_manager, turn_manager)
