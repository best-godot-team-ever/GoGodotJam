extends CanvasLayer

onready var dialogue_0 = Dialogic.start("story_0")
onready var dialogue_1 = Dialogic.start("story_1")
onready var dialogue_2 = Dialogic.start("story_2")
onready var dialogue_3 = Dialogic.start("story_3")
onready var dialogue_4 = Dialogic.start("story_4")
onready var dialogue_5 = Dialogic.start("story_5")

onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.play("0_fade_in")
	BgmManager.stream = load("res://assets/sounds/bgm/History_Panel_Theme.mp3")
	BgmManager.play()
	

func _play_dialogue(dialogue_number: int) -> void:
	match dialogue_number:
		0:
			add_child(dialogue_0)
		1:
			add_child(dialogue_1)
		2:
			add_child(dialogue_2)
		3:
			add_child(dialogue_3)
		4:
			add_child(dialogue_4)
		5:
			add_child(dialogue_5)

func play_next_story(next_story: Array) -> void:
	match next_story[0]:
		"1":
			anim_player.play("1_fade_in")
		"2":
			anim_player.play("2_fade_in")
		"3":
			anim_player.play("3_fade_in")
		"4":
			anim_player.play("4_fade_in")
		"5":
			anim_player.play("5_fade_in")
		"6":
			anim_player.play("start_game")

func start_game() -> void:
	get_tree().change_scene("res://src/Levels/Level_00.tscn")
	BgmManager.stream = load("res://assets/sounds/bgm/Main_Level_Music_V2.mp3")
	BgmManager.play()

func _input(event):
	if event.is_action_pressed("toggle_cell_numbers"):
		start_game()

