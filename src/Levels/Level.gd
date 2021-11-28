extends Node2D


onready var board_manager = $BoardManager
onready var turn_manager = $TurnManager
onready var dialogue_manager = $DialogueManager

func _ready() -> void:
	turn_manager.init(board_manager)
	for child in $YSort.get_children():
		child.init(board_manager, turn_manager)
	for child in $Dialogues.get_children():
		child.init(board_manager, turn_manager)
	

