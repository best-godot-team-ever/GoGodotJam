extends "res://src/Entity/Entity.gd"

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	._initialize(board_manager, turn_manager)
	_turn_manager.subscribe_enemy(self)
