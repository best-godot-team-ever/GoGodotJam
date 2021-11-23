extends Node
class_name TurnManager

var _board_manager: Node

var machines: Array = []
var enemies: Array = []
var triggers : Array = []
var player

func init(board_manager: BoardManager) -> void:
	_board_manager = board_manager

func subscribe_machine(machine: Node) -> void:
	machines.append(machine)

func subscribe_enemy(enemy: Node) -> void:
	enemies.append(enemy)

func subscribe_trigger(trigger: Node) -> void:
	triggers.append(trigger)

func end_turn() -> void:
	triggers.sort_custom(self,"_sort")
	for trigger in triggers:
		trigger.start_turn()
	
	machines.sort_custom(self,"_sort")
	for machine in machines:
		machine.start_turn()
	
	enemies.sort_custom(self,"_sort")
	for enemy in enemies:
		enemy.start_turn()

	_board_manager.drain_energy()
	
	player.start_turn()

func _sort(entity1, entity2) -> bool:
	return entity1.turn_speed > entity2.turn_speed
