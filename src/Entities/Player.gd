extends Node2D

var turn_manager : Resource = preload("res://src/Managers/TurnManager.tres")


func _ready() -> void:
	turn_manager.player = self

# just to test the turns
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		turn_manager.end_turn()

func start_turn() -> void:
	pass
