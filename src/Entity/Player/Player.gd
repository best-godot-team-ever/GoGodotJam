extends "res://src/Entity/Entity.gd"

enum {Move, Pulse}

var sound_pulse = preload("res://assets/sounds/sfx/Player_Pulse.mp3")
var sound_move = preload("res://assets/sounds/sfx/Player_Move.mp3")

const NO_ACTION = -1

onready var viewport_midpoint: Vector2 = get_viewport_rect().size / 2
onready var health_bar = get_parent().get_parent().find_node("HealthBar")
onready var lose_menu = get_parent().get_parent().find_node("LoseMenu")
onready var camera = $Camera2D
onready var anim_player = $AnimationPlayer


var move_direction = Vector2()
var next_action_queue = NO_ACTION

var health := 100.0 setget set_health
var max_health := 100

var has_wait = true
var has_pulse = true

var _is_dead := false
var is_talking:= false
var is_dead_or_talking = _is_dead or is_talking


func _initialize(board_manager: Node, turn_manager: Node) -> void:
	._initialize(board_manager, turn_manager)
	_turn_manager.set_player_entity_id(entity_id)
	_board_manager.set_energy(get_current_position(), 3)
	_board_manager.drain_energy()

func _process(_delta: float) -> void:
	if next_action_queue != NO_ACTION and _turn_manager.is_player_turn:
		_commit_action(next_action_queue)

func _move() -> bool:
	# Plan the Turn
	var planned_position = get_current_position() + move_direction

	next_action_queue = NO_ACTION
	var cell_data = _board_manager.get_cell(planned_position)
	if not move_direction == Vector2.ZERO and (not cell_data.is_in_level or cell_data.is_blocked):
		return false

	# Execute the Turn
	move_on_map(move_direction)
	if move_direction == Vector2(0, 0):
		self.health += 10
	else:
		self.health += 5
	return true

func _pulse() -> bool:
	next_action_queue = NO_ACTION

	if health <= 60:
		return false
	
	self.health -= 60
	var radius = 3
	var coord = get_current_position()
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			var target = Vector2(coord.x + x, coord.y + y)
			if coord.distance_to(target) > radius - 0.5 and coord.distance_to(target) != radius:
				continue
			elif coord.distance_to(target) <= 1:
				var cell_data = _board_manager.get_cell(target)
				_board_manager.set_energy(target, 5 if cell_data.energy_level < 5 else cell_data.energy_level + 1)
			elif coord.distance_to(target) <= 2:
				var cell_data = _board_manager.get_cell(target)
				_board_manager.set_energy(target, 4 if cell_data.energy_level < 4 else cell_data.energy_level + 1)
			else:
				var cell_data = _board_manager.get_cell(target)
				_board_manager.set_energy(target, 3 if cell_data.energy_level < 3 else cell_data.energy_level + 1)

	# This is here for now... but it rly should have an animation attached to it
	anim_state_machine.travel("pulse")
	audio_stream.stream = sound_pulse
	audio_stream.play()
	_fake_animation()
	return true

func _commit_action(action: int) -> void:
	if not _turn_manager.is_player_turn:
		next_action_queue = action if next_action_queue == NO_ACTION or next_action_queue != action else NO_ACTION
		return

	match action:
		Move:
			if not _move():
				return
		Pulse:
			if not _pulse():
				return
	
	_turn_manager.end_turn()

func _unhandled_input(event: InputEvent) -> void:
	if !_is_dead and !is_talking:
		if event.is_pressed() and not event.is_echo():
			if event.is_action("aim_up"):
				_update_facing_direction(Vector2.UP)
				_commit_action(Move)
			elif event.is_action("aim_down"):
				_update_facing_direction(Vector2.DOWN)
				_commit_action(Move)
			elif event.is_action("aim_left"):
				_update_facing_direction(Vector2.LEFT)
				_commit_action(Move)
			elif event.is_action("aim_right"):
				_update_facing_direction(Vector2.RIGHT)
				_commit_action(Move)
			elif event.is_action("aim_cancel") and has_wait:
				_update_facing_direction(Vector2.ZERO)
				_commit_action(Move)
			elif event.is_action("commit_move"):
				_commit_action(Move)
			elif event.is_action("commit_pulse") and has_pulse:
				_commit_action(Pulse)

			# Mouse Input
			elif event.is_action("commit_mouse_move"):
				_update_facing_direction(_get_mouse_facing_direction(event.get_position()))
				_commit_action(Move)
			elif event.is_action("commit_mouse_skip") and has_wait:
				_update_facing_direction(Vector2.ZERO)
				_commit_action(Move)
			
			if event.is_action("toggle_cell_numbers"):
				_board_manager.visibility += 1


func _get_mouse_facing_direction(screen_space_coord: Vector2) -> Vector2:
	var offset = viewport_midpoint - screen_space_coord
	offset = Vector2(sign(offset.x), sign(offset.y))

	if offset == Vector2(1,1):
		return Vector2.LEFT
	elif offset == Vector2(-1,-1):
		return Vector2.RIGHT
	elif offset == Vector2(1, -1):
		return Vector2.DOWN
	elif offset == Vector2(-1, 1):
		return Vector2.UP
	
	return Vector2()

func move_on_map(direction: Vector2):
	.move_on_map(direction)
	if not direction == Vector2.ZERO:
		anim_state_machine.travel("move")
		audio_stream.stream = sound_move
		audio_stream.play()	
	_board_manager.set_energy(get_current_position(), 3 if direction.length() != 0 else _board_manager.get_cell(get_current_position()).get("energy_level") + 1)
	
func _update_facing_direction(direction: Vector2) -> void:
	move_direction = direction

	if not _turn_manager.is_player_turn or direction == Vector2.ZERO:
		return

	animation_tree["parameters/idle/blend_position"] = direction
	animation_tree["parameters/move/blend_position"] = direction
	animation_tree["parameters/pulse/blend_position"] = direction

func _animation_finished() -> void:
	_turn_manager.ready_for_turn()
	_update_facing_direction(move_direction)
	if not _is_dead:
		anim_state_machine.travel("idle")


# This is just to emulate a fake animation
func _fake_animation() -> void:
	yield(get_tree().create_timer(0.4), "timeout")
	_animation_finished()

func set_health(value) -> void:
	health = value
	health = clamp(health, 0, max_health)
	health_bar.set_health_value(value)
	if health == 0:
		_die()

func take_damage(amount: int) -> void:
	self.health -= amount

func _die() -> void:
	_is_dead = true
	lose_menu._is_opened = true
	lose_menu.visible = true
	anim_player.play("camera_zoom")
	anim_state_machine.travel("die")
