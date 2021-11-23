extends Node2D
class_name Machines

enum MachineType {Door, LaserUp, LaserDown, EnergyTrigger, PlateTrigger}
enum Blockers {Door, LaserUp, LaserDown}
enum MachineStates {Activated, Deactivated}


export (String, "Door", "LaserUp", "LaserDown", "EnergyTrigger", "PlateTrigger") var entity_type
export var turn_speed: int = 0
export (MachineType) var machine_type 

onready var tween = $Tween

var _board_manager: BoardManager
var _turn_manager: TurnManager

var power_on : bool = false setget set_power_on
var current_state: int = MachineStates.Deactivated
var _map_position : Vector2
var _blockers : Array = ["Door", "LaserUp", "LaserDown"]


func _ready() -> void:
	tween.connect("tween_all_completed", self, "_animation_finished")

func init(board_manager: BoardManager, turn_manager: TurnManager) -> void:
	_initialize(board_manager, turn_manager)

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	_board_manager = board_manager
	_turn_manager = turn_manager
	_map_position = _board_manager.world_to_map(position)
	position = _board_manager.map_to_world(_map_position)
	if entity_type in Blockers:
		_board_manager.set_machine_blocking(_board_manager.add_machine(self, _map_position), true)

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
