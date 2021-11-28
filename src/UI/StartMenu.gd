extends Node2D

onready var new_game = $NewGame
onready var quit_game =$QuitGame


func _on_NewGame_pressed() -> void:
	get_tree().change_scene("res://src/UI/IntroStory.tscn")

func _on_QuitGame_pressed() -> void:
	get_tree().quit()
