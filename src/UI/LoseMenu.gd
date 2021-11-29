extends Control

var _is_opened := false

onready var _restart = $Restart
onready var _quit_game = $QuitGame


func _on_Restart_pressed() -> void:
	if _is_opened:
		get_tree().paused = false
		get_tree().reload_current_scene()

func _on_QuitGame_pressed() -> void:
	if _is_opened:
		get_tree().quit()
