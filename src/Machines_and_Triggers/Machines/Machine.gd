extends Node2D
class_name Machines

enum MachineType {Door, LaserUp, LaserDown, EnergyTrigger, PlateTrigger}
enum Blockers {Door, LaserUp, LaserDown}
enum MachineStates {Activated, Deactivated}

export var turn_speed: int = 0
export (MachineType) var machine_type 

#onready var tween = $Tween
onready var _animated_sprite = $AnimatedSprite

var _board_manager: BoardManager
var _turn_manager: TurnManager
var machine_id : int

var power_on : bool = false setget set_power_on
var current_state: int = MachineStates.Deactivated
var _map_position : Vector2
var _blockers : Array = [MachineType.Door, MachineType.LaserUp, MachineType.LaserDown]


#func _ready() -> void:
#	tween.connect("tween_all_completed", self, "_animation_finished")

func init(board_manager: BoardManager, turn_manager: TurnManager) -> void:
	_initialize(board_manager, turn_manager)

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	_board_manager = board_manager
	_turn_manager = turn_manager
	_turn_manager.subscribe_machine(self)
	_map_position = _board_manager.world_to_map(position)
	position = _board_manager.map_to_world(_map_position)
	machine_id = _board_manager.add_machine(self, _map_position)
	if machine_type in _blockers:
		_board_manager.set_machine_blocking(machine_id, true)

func start_turn() -> void:
	pass

func _animation_finished() -> void:
	pass

func set_power_on(value: bool) -> void:
	power_on = value
	if power_on == true:
		current_state = MachineStates.Activated
		_animated_sprite.play("activated")
	if power_on == false:
		current_state = MachineStates.Deactivated
		_animated_sprite.play("deactivated")
