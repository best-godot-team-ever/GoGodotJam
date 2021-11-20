extends Sprite

func _process(_delta: float) -> void:
	position.y = sin(OS.get_ticks_msec() / 200.0) * 4.0