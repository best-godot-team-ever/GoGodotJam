extends Node2D


export (PackedScene) var _next_level
export var _fake := false

var _board_manager: BoardManager
var _turn_manager: TurnManager

var _map_position : Vector2

onready var _player = get_parent().get_parent().find_node("Player")
onready var fade_in = get_parent().get_parent().find_node("FadeIn").get_node("AnimationPlayer")

func init(board_manager: BoardManager, turn_manager: TurnManager) -> void:
	_initialize(board_manager, turn_manager)

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	_board_manager = board_manager
	_turn_manager = turn_manager
	_map_position = _board_manager.world_to_map(position)
	position = _board_manager.map_to_world(_map_position)
	if ! _fake:
		# this is ugly beyond ugly, but it dosnt really matter for now. Its just to get a turn
		_turn_manager.subscribe_dialogue(self)

func start_turn() -> void:
	if ! _fake:
		if _board_manager.get_cell(_board_manager.world_to_map(position)).is_blocked:
			_player.anim_player.play("camera_zoom_2")
			fade_in.play("fade_out")
			yield(get_tree().create_timer(3.0), "timeout")
			get_tree().change_scene(_next_level.get_path())

func _input(event):
	if Input.is_action_pressed("coward_button"):
		_player.anim_player.play("camera_zoom_2")
		fade_in.play("fade_out")
		yield(get_tree().create_timer(3.0), "timeout")
		get_tree().change_scene(_next_level.get_path())

