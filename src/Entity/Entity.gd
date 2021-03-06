extends Node2D

enum EntityType {Player, Grabber, Leecher}

onready var tween = $Tween
onready var animation_tree = $AnimationTree
onready var anim_state_machine = $AnimationTree["parameters/playback"]
onready var audio_stream = $AudioStreamPlayer2D

var _board_manager: BoardManager
var _turn_manager: TurnManager

var entity_id: int
export(EntityType) var entity_type
export var turn_speed: int = 0

func _ready() -> void:
	tween.connect("tween_all_completed", self, "_animation_finished")

func init(board_manager: BoardManager, turn_manager: TurnManager) -> void:
	_initialize(board_manager, turn_manager)

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	_board_manager = board_manager
	_turn_manager = turn_manager

	entity_id = _board_manager.add_entity(self, board_manager.world_to_map(position))
	assert(entity_id != _board_manager.entity_grid.NO_ENTITY)

	position = _board_manager.map_to_world(get_current_position())

func get_surrounding_tiles() -> Dictionary:


	return {}

func move_on_map(direction: Vector2):
	_board_manager.update_entity_position(entity_id, get_current_position() + direction)
	
	# Make this run in a tween instead?
	var target_position = _board_manager.map_to_world(get_current_position())
	tween.interpolate_property(self, "position",
		position, target_position, 0.3,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func get_current_position() -> Vector2:
	return _board_manager.get_entity_position_by_id(entity_id)

# This function should be overwritten in specific classes?
# or we can break this down further.
func start_turn() -> void:
	pass

func _animation_finished() -> void:
	pass
