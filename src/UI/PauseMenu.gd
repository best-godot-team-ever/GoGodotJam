extends Control

var _is_opened := false

onready var _continue = $Continue
onready var _restart = $Restart
onready var _quit_game = $QuitGame

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and !_is_opened:
		_is_opened = true
		visible = true
		get_tree().paused = true
	elif event.is_action_pressed("ui_cancel") and _is_opened:
		_is_opened = false
		visible = false
		get_tree().paused = false


func _on_Continue_pressed() -> void:
	if _is_opened:
		_is_opened = false
		visible = false
		get_tree().paused = false

func _on_Restart_pressed() -> void:
	if _is_opened:
		get_tree().paused = false
		get_tree().reload_current_scene()

func _on_QuitGame_pressed() -> void:
	if _is_opened:
		get_tree().quit()

