extends Node2D


onready var board_manager = $BoardManager
onready var turn_manager = $TurnManager
onready var intro_dialogue = Dialogic.start("level00_0") 
onready var ui_fade_in = $UI/FadeIn/AnimationPlayer
onready var player = find_node("Player")

func _ready() -> void:
	turn_manager.init(board_manager)
	for child in $YSort.get_children():
		child.init(board_manager, turn_manager)
	for child in $Dialogues.get_children():
		child.init(board_manager, turn_manager)
	add_child(intro_dialogue)
	ui_fade_in.play("fade_in")
	player.has_pulse = false
	player.has_wait = false
	

