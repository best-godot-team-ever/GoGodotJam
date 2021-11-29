extends CanvasLayer


func _on_VideoPlayer_finished():
	$AnimationPlayer.play("theme")

func go_to_menu() -> void:
	get_tree().change_scene("res://src/UI/StartMenu.tscn")

func _input(event):
	if event.is_action_pressed("toggle_cell_numbers"):
		get_tree().change_scene("res://src/UI/StartMenu.tscn")
