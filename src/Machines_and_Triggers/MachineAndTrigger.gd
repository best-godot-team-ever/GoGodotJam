extends Node2D
class_name MachineAndTrigger

enum MachineType {Door, DoorChanging, LaserUp, LaserDown, EnergyTrigger, PlateTrigger}
var _triggers : Array = [MachineType.EnergyTrigger, MachineType.PlateTrigger]

export var turn_speed: int = 0

var _board_manager: BoardManager
var _turn_manager: TurnManager
var machine_id : int
var machine_type 

var _map_position : Vector2

onready var _animated_sprite = $AnimatedSprite

#onready var tween = $Tween
#func _ready() -> void:
#	tween.connect("tween_all_completed", self, "_animation_finished")

func init(board_manager: BoardManager, turn_manager: TurnManager) -> void:
	_initialize(board_manager, turn_manager)

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	_board_manager = board_manager
	_turn_manager = turn_manager
	_map_position = _board_manager.world_to_map(position)
	position = _board_manager.map_to_world(_map_position)
	machine_id = _board_manager.add_machine(self, _map_position)
	if machine_type in _triggers:
		_turn_manager.subscribe_trigger(self)
	if ! machine_type in _triggers:
		_board_manager.set_machine_blocking(machine_id, true)
		_turn_manager.subscribe_machine(self)

func start_turn() -> void:
	pass

func _animation_finished() -> void:
	pass


