extends Node2D


export (String) var _dialogue_string
export var give_wait : bool = false
export var give_pulse : bool = false

var _board_manager: BoardManager
var _turn_manager: TurnManager

var _map_position : Vector2
var _dialogue
var _used = false


onready var _player = get_parent().get_parent().find_node("Player")


func init(board_manager: BoardManager, turn_manager: TurnManager) -> void:
	_initialize(board_manager, turn_manager)

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	_board_manager = board_manager
	_turn_manager = turn_manager
	_turn_manager.subscribe_dialogue(self)
	_map_position = _board_manager.world_to_map(position)
	position = _board_manager.map_to_world(_map_position)
	_dialogue = Dialogic.start(_dialogue_string)
	self.visible = false

func start_turn() -> void:
	if _board_manager.get_cell(_board_manager.world_to_map(position)).is_blocked and ! _used:
		add_child(_dialogue)
		_used = true
		_player.is_talking = true
		if give_pulse:
			_player.has_pulse = true
		if give_wait:
			_player.has_wait = true
	if _used:
		_turn_manager.dialogue_triggers.erase(self)

func end_dialogue() -> void:
	_player.is_talking = false




