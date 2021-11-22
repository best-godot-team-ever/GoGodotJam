extends Node2D
class_name Trigger

export (Array, PackedScene) var _link_with_machines
export var turn_speed : int = 0

enum TriggerStates {Activated, Deactivated}

var current_state: int = TriggerStates.Deactivated

onready var _board_manager = get_parent().get_node("BoardManager")


func start_turn() -> void:
	pass

func power_up_machines() -> void:
	for machine in _link_with_machines:
		machine.set_power_on(true)

func shut_down_machines() -> void:
	for machine in _link_with_machines:
		machine.set_power_on(false)




