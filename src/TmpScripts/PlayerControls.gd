extends Node2D

onready var board_manager = get_parent().get_node("BoardManager")

var current_coord = Vector2()

func _ready() -> void:
    position = board_manager.map_to_world(current_coord)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed() and not event.is_echo():
		if event.is_action("ui_up") and board_manager.is_valid_move(current_coord + Vector2.LEFT):
			current_coord.x -= 1
			position = board_manager.map_to_world(current_coord)
		elif event.is_action("ui_down") and board_manager.is_valid_move(current_coord + Vector2.RIGHT):
			current_coord.x += 1
			position = board_manager.map_to_world(current_coord)
		elif event.is_action("ui_left") and board_manager.is_valid_move(current_coord + Vector2.DOWN):
			current_coord.y += 1
			position = board_manager.map_to_world(current_coord)
		elif event.is_action("ui_right") and board_manager.is_valid_move(current_coord + Vector2.UP):
			current_coord.y -= 1
			position = board_manager.map_to_world(current_coord)
