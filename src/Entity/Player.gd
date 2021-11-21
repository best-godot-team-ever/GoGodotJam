extends "res://src/Entity/Entity.gd"

var move_direction = Vector2()
var is_player_turn = true

var is_next_turn_queued = false

func _process(_delta: float) -> void:
	if is_next_turn_queued and is_player_turn:
		start_turn()

func start_turn() -> void:
	if not is_player_turn:
		is_next_turn_queued = not is_next_turn_queued
		return
	# if not turn_manager.is_player_turn(): return

	# Plan the Turn
	var planned_position = get_current_position() + move_direction

	is_next_turn_queued = false
	if not _board_manager.is_in_level(planned_position):
		return

	# Execute the Turn
	is_player_turn = false
	move_on_map(move_direction)

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
		if event.is_action("ui_accept"):
			start_turn()

func _animation_finished() -> void:
	is_player_turn = true

func move_on_map(direction: Vector2):
	.move_on_map(direction)
	_board_manager.set_energy(get_current_position(), 3)
