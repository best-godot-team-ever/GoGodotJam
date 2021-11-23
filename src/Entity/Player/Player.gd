extends "res://src/Entity/Entity.gd"


onready var anim_player : = $AnimationPlayer

var move_direction = Vector2()

var is_next_turn_queued = false


#### ANIMATIONS
func _ready() -> void:
	anim_player.play("idle_front_right")
#### ANIMATIONS


func _initialize(board_manager: Node, turn_manager: Node) -> void:
	._initialize(board_manager, turn_manager)
	_turn_manager.set_player_entity_id(entity_id)

func _process(_delta: float) -> void:
	if is_next_turn_queued and _turn_manager.is_player_turn:
		start_turn()

func start_turn() -> void:
	if not _turn_manager.is_player_turn:
		is_next_turn_queued = not is_next_turn_queued
		return

	# Plan the Turn
	var planned_position = get_current_position() + move_direction

	is_next_turn_queued = false
	if not _board_manager.is_in_level(planned_position):
		return

	# Execute the Turn
	move_on_map(move_direction)

	_turn_manager.end_turn()
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed() and not event.is_echo():
		if event.is_action("ui_up"):
			move_direction = Vector2.UP
		elif event.is_action("ui_down"):
			move_direction = Vector2.DOWN
		elif event.is_action("ui_left"):
			move_direction = Vector2.LEFT
		elif event.is_action("ui_right"):
			move_direction = Vector2.RIGHT
		elif event.is_action("ui_cancel"):
			move_direction = Vector2.ZERO
		elif event.is_action("ui_accept"):
			start_turn()
		_animate()

func _animation_finished() -> void:
	_turn_manager.ready_for_turn()

func move_on_map(direction: Vector2):
	.move_on_map(direction)
	_board_manager.set_energy(get_current_position(), 3 if direction.length() != 0 else _board_manager.get_cell(get_current_position()).get("energy_level") + 1)


#### ANIMATIONS
func _animate() -> void:
	if move_direction.y < 0:
		anim_player.play("move_back_right")
	if move_direction.y > 0:
		anim_player.play("move_front_left")
	if move_direction.x < 0:
		anim_player.play("move_back_left")
	if move_direction.x > 0:
		anim_player.play("move_front_right")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	match anim_name:
		"move_back_right":
			anim_player.play("idle_back_right")
		"move_back_left":
			anim_player.play("idle_back_left")
		"move_front_right":
			anim_player.play("idle_front_right")
		"move_front_left":
			anim_player.play("idle_front_left")

##### END OF ANIMATIONS

func test_func(anim_name : String) -> void:
	match anim_name:
		"move_back_right":
			_on_AnimationPlayer_animation_finished(anim_name)
