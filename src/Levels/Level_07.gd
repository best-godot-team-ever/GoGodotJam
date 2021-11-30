extends Node2D


onready var board_manager = $BoardManager
onready var turn_manager = $TurnManager
onready var ui_fade_in = $UI/FadeIn/AnimationPlayer
onready var player = find_node("Player")

func _ready() -> void:
	turn_manager.init(board_manager)
	for child in $YSort.get_children():
		child.init(board_manager, turn_manager)
	for child in $Dialogues.get_children():
		child.init(board_manager, turn_manager)
	ui_fade_in.play("fade_in")
	BgmManager.stop()
	BgmManager.stream = load("res://assets/sounds/bgm/ambience.mp3")
	BgmManager.play()

