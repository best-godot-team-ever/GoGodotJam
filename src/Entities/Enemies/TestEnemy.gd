extends Enemy


func start_turn() -> void:
	position += Vector2(10,15)
	yield(get_tree().create_timer(0.0), "timeout")

