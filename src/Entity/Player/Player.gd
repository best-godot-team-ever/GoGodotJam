extends "res://src/Entity/Entity.gd"

enum {Move, Pulse}

const NO_ACTION = -1

onready var animated_sprite = $AnimatedSprite

var move_direction = Vector2()

var movable_cells : Array = []

var next_action_queue = NO_ACTION


var health = 100

func _initialize(board_manager: Node, turn_manager: Node) -> void:
	._initialize(board_manager, turn_manager)
	_turn_manager.set_player_entity_id(entity_id)

func _process(_delta: float) -> void:
	if next_action_queue != NO_ACTION and _turn_manager.is_player_turn:
		_commit_action(next_action_queue)

func _move() -> bool:
	# Plan the Turn
	var planned_position = get_current_position() + move_direction

	next_action_queue = NO_ACTION
	var cell_data = _board_manager.get_cell(planned_position)
	if not cell_data.is_in_level or cell_data.is_blocked:
		return false

	# Execute the Turn
	move_on_map(move_direction)
	return true

func _pulse() -> bool:
	next_action_queue = NO_ACTION

	if health <= 60:
		$Label.set_text("No pulse, Energy low %s" % health)
		return false
	
	health -= 60
	$Label.set_text("pulse! %s" % health)
	var radius = 2
	var coord = get_current_position()
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			var target = Vector2(coord.x + x, coord.y + y)
			var cell_data = _board_manager.get_cell(target)
			_board_manager.set_energy(target, 3 if cell_data.energy_level < 3 else cell_data.energy_level + 1)


	# This is here for now... but it rly should have an animation attached to it
	_fake_animation()
	return true

func _commit_action(action: int) -> void:
	if not _turn_manager.is_player_turn:
		next_action_queue = action if next_action_queue == NO_ACTION or next_action_queue != action else NO_ACTION
		return

	$Label.set_text("")

	match action:
		Move:
			if not _move():
				return
		Pulse:
			if not _pulse():
				return
	
	_turn_manager.end_turn()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed() and not event.is_echo():
		if event.is_action("aim_up"):
			_update_facing_direction(Vector2.UP)
		elif event.is_action("aim_down"):
			_update_facing_direction(Vector2.DOWN)
		elif event.is_action("aim_left"):
			_update_facing_direction(Vector2.LEFT)
		elif event.is_action("aim_right"):
			_update_facing_direction(Vector2.RIGHT)
		elif event.is_action("aim_cancel"):
			_update_facing_direction(Vector2.ZERO)
		elif event.is_action("commit_move"):
			_commit_action(Move)
		elif event.is_action("commit_pulse"):
			_commit_action(Pulse)

func move_on_map(direction: Vector2):
	.move_on_map(direction)
	_play_moving_animation()
	_board_manager.set_energy(get_current_position(), 3 if direction.length() != 0 else _board_manager.get_cell(get_current_position()).get("energy_level") + 1)

func _play_moving_animation():
	if animated_sprite.animation == "idle_back":
		animated_sprite.play("moving_back")
	else:
		animated_sprite.play("moving_front")

func _update_facing_direction(direction: Vector2):
	move_direction = direction

	if not _turn_manager.is_player_turn:
		return

	match direction:
		Vector2.UP:
			animated_sprite.play("idle_back")
			animated_sprite.flip_h = false
		Vector2.DOWN:
			animated_sprite.play("idle_front")
			animated_sprite.flip_h = false


		Vector2.LEFT:
			animated_sprite.play("idle_back")
			animated_sprite.flip_h = true

		Vector2.RIGHT:
			animated_sprite.play("idle_front")
			animated_sprite.flip_h = true


func _animation_finished() -> void:
	_turn_manager.ready_for_turn()
	_update_facing_direction(move_direction)
	# Lol.... Here?
	health += 0 if health == 100 else 10

# This is just to emulate a fake animation
func _fake_animation() -> void:
	yield(get_tree().create_timer(0.3), "timeout")
	_animation_finished()
