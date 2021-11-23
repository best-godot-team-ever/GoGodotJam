extends Sprite

export var frequency: float = 200.0
export var amplitude: float = 1.0

func _process(_delta: float) -> void:
	position.y = sin(OS.get_ticks_msec() / frequency) * amplitude
