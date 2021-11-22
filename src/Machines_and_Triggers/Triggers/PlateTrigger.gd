extends Node2D

export (Array, PackedScene) var _link_with_machines
export var turn_speed : int = 0

enum PlateTriggerStates {Activated, Deactivated}

var current_state: int = PlateTriggerStates.Deactivated
var _is_occupied : bool = false

onready var _board_manager = get_parent().get_node("BoardManager")


func start_turn() -> void:
	_is_occupied = _board_manager.is_occupied(_board_manager.world_to_map(position))
	match _is_occupied:
		true:
			power_up_machines()
			current_state = PlateTriggerStates.Activated
		false:
			shut_down_machines()
			current_state = PlateTriggerStates.Deactivated

func power_up_machines() -> void:
	for machine in _link_with_machines:
		machine.set_power_on(true)

func shut_down_machines() -> void:
	for machine in _link_with_machines:
		machine.set_power_on(false)




