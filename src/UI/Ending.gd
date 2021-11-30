extends CanvasLayer

onready var dialogue_0 = Dialogic.start("ending_0")
onready var dialogue_1 = Dialogic.start("ending_1")

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

func play_next_story(next_story: Array) -> void:
	match next_story[0]:
		"1":
			anim_player.play("1_fade_in")
		"2":
			anim_player.play("end_game")
			BgmManager.stream = load("res://assets/sounds/bgm/Main_Level_Music_V2.mp3")
			BgmManager.play()


func end_game() -> void:
	get_tree().change_scene("res://src/UI/Credits.tscn")


func _input(event):
	if event.is_action_pressed("toggle_cell_numbers"):
		end_game()

