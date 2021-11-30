extends Control

onready var bar = $TextureProgress
onready var tween = $Tween

func set_health_value(value: int) -> void:
	tween.interpolate_property(bar, "value", bar.value, value, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
