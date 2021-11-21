extends Node2D

# This script will pass Board Manager into every Entity class

onready var board_manager = $BoardManager

func _ready() -> void:
    for entity in $Entities.get_children():
        entity.init(board_manager)