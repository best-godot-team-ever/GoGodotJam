extends Node

class_name TurnManager

var _board_manager: Node

var machines: Array = []
var enemies: Array = []

var is_player_turn = true

var player_entity_id = -1

func init(board_manager: BoardManager) -> void:
	_board_manager = board_manager

func set_player_entity_id(player_id: int) -> void:
	player_entity_id = player_id

func subscribe_machine(machine: Node) -> void:
	machines.append(machine)

func subscribe_enemy(enemy: Node) -> void:
	enemies.append(enemy)

# Only the player can end turn...
func end_turn() -> void:
	is_player_turn = false
	machines.sort_custom(self,"_sort")
	for machine in machines:
		machine.start_turn()
	
	enemies.sort_custom(self,"_sort")
	for enemy in enemies:
		enemy.start_turn()

	_board_manager.drain_energy()

func ready_for_turn() -> void:
	is_player_turn = true

func _sort(entity1, entity2) -> bool:
	return entity1.turn_speed > entity2.turn_speed
