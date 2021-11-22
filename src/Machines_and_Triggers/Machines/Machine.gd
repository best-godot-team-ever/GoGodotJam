extends Node2D
class_name Machines

enum MachineType {Door, LaserUp, LaserDown}
enum MachineStates {Activated, Deactivated}

onready var tween = $Tween

var _board_manager: BoardManager
var _turn_manager: TurnManager
var power_on : bool = false setget set_power_on
var current_state: int = MachineStates.Deactivated

#
#var entity_id: int
#export(EntityType) var entity_type
#export var turn_speed: int = 0

func _ready() -> void:
	tween.connect("tween_all_completed", self, "_animation_finished")

func init(board_manager: BoardManager, turn_manager: TurnManager) -> void:
	_initialize(board_manager, turn_manager)

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	_board_manager = board_manager
	_turn_manager = turn_manager

#	entity_id = _board_manager.add_entity(self, board_manager.world_to_map(position))
#	assert(entity_id != _board_manager.entity_grid.NO_ENTITY)
#
#	position = _board_manager.map_to_world(get_current_position())


func get_current_position() -> Vector2:
	return Vector2.ZERO
#	return _board_manager.get_entity_position_by_id(entity_id)

# This function should be overwritten in specific classes?
# or we can break this down further.
func start_turn() -> void:
	pass

func _animation_finished() -> void:
	pass

func set_power_on(value: bool) -> void:
	power_on = value
	if power_on == true:
		current_state = MachineStates.Activated
	if power_on == false:
		current_state = MachineStates.Deactivated
