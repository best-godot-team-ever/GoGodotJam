extends Node2D
class_name Machine

export var turn_speed : int 
export var link_with_trigger : int

var turn_manager : Resource = preload("res://src/Managers/TurnManager.tres")

func _ready() -> void:
	turn_manager.machines.append(self)

# virtual method Objects that extend Enemy should have
func start_turn() -> void:
	pass
