extends "res://src/Entity/Entity.gd"

onready var animated_sprite = $AnimatedSprite

var move_direction = Vector2()
var movable_cells : Array = []

var is_next_turn_queued = false

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
		_update_look_animation()

func _animation_finished() -> void:
	_turn_manager.ready_for_turn()

func move_on_map(direction: Vector2):
	.move_on_map(direction)
	_board_manager.set_energy(get_current_position(), 3 if direction.length() != 0 else _board_manager.get_cell(get_current_position()).get("energy_level") + 1)

func _update_look_animation() -> void:
	if move_direction.y < 0 or move_direction.x < 0:
		animated_sprite.play("idle_left")
	else:
		animated_sprite.play("idle_right")
