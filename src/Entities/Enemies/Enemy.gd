extends Node2D
class_name Enemy

export var turn_speed : int 

var turn_manager : Resource = preload("res://src/Managers/TurnManager.tres")

func _ready() -> void:
	turn_manager.enemies.append(self)

# virtual method Objects that extend Enemy should have
func start_turn() -> void:
	pass
