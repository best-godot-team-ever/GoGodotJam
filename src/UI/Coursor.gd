extends Node2D
class_name Coursor

var cell : Vector2

onready var _board_manager = get_parent().get_node("BoardManager")
onready var _player = get_parent().get_node("Entities").get_node("Player")

func _process(delta: float) -> void:
	position = get_global_mouse_position()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cell = _board_manager.world_to_map(position)

	if event.is_action_pressed("left_click"):
		cell = _board_manager.world_to_map(position)
		if cell in _player._movable_cells:
			_player.move_to(cell)
		get_tree().set_input_as_handled()



