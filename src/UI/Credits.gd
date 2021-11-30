extends CanvasLayer

onready var anim_player = $AnimationPlayer

func _ready():
	play_next(6)


func play_next(i: int) -> void:
	match i:
		1:
			anim_player.play("1_fade")
		2:
			anim_player.play("2_fade")
		3:
			anim_player.play("3_fade")
		4:
			anim_player.play("4_fade")
		5:
			anim_player.play("5_fade")
		6:
			anim_player.play("6_fade")
		7:
			anim_player.play("7_fade")
		8:
			anim_player.play("8_fade")
		9:
			anim_player.play("9_fade")
		10:
			anim_player.play("10_fade")
		11:
			anim_player.play("11_fade")
