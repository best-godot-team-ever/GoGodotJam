extends Control

onready var bar = $TextureProgress
onready var tween = $Tween
onready var player = get_parent().get_parent().find_node("Player")


#func _on_health_updated(health, amount) -> void:
#	tween.interpolate_property(bar, "value", bar.value, health, 0.4, tween.TRANS_SINE, tween.EASE_IN_OUT)
#	tween.start()
