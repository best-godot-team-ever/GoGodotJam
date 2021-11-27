extends Node2D


export (PackedScene) var _next_level

var _board_manager: BoardManager
var _turn_manager: TurnManager

var _map_position : Vector2

onready var _player = get_parent().get_parent().find_node("Player")

func init(board_manager: BoardManager, turn_manager: TurnManager) -> void:
	_initialize(board_manager, turn_manager)

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	_board_manager = board_manager
	_turn_manager = turn_manager
	# this is ugly beyond ugly, but it dosnt really matter for now. Its just to get a turn
	_turn_manager.subscribe_dialogue(self)
	_map_position = _board_manager.world_to_map(position)
	position = _board_manager.map_to_world(_map_position)

func start_turn() -> void:
	if _board_manager.get_cell(_board_manager.world_to_map(position)).is_blocked:
		get_tree().change_scene(_next_level.get_path())

