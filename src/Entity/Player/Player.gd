extends "res://src/Entity/Entity.gd"


onready var anim_player : = $AnimationPlayer


const Directions : Array = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

var _is_turn : bool = true
var _movable_cells : Array = []
var _new_cell_up
var _new_cell_down
var _new_cell_left
var _new_cell_right 
var health := 100.0 setget set_health
var _max_health := 100
var _pulse_radius = 2



#### ANIMATIONS
func _ready() -> void:
	anim_player.play("idle_front_right")
#### ANIMATIONS


func _initialize(board_manager: Node, turn_manager: Node) -> void:
	._initialize(board_manager, turn_manager)
	_turn_manager.player = self
	start_turn()

func start_turn() -> void:
	_set_new_cells(get_current_position())
	_movable_cells = _get_movable_cells(get_current_position())
	_is_turn = true


func _set_new_cells(current_position: Vector2) -> void:
	_new_cell_up = get_current_position() + Vector2.UP
	_new_cell_down = get_current_position() + Vector2.DOWN
	_new_cell_left = get_current_position() + Vector2.LEFT
	_new_cell_right = get_current_position() + Vector2.RIGHT
	

func _get_movable_cells(current_position : Vector2) -> Array:
	var out : Array
	for direction in Directions:
		var test_cell = current_position + direction
		var test_cell_data = _board_manager.get_cell(test_cell)
		if  !test_cell_data.is_in_level or test_cell_data.is_blocked:
			continue
		out.append(test_cell)
	return out

func _move_to(new_cell: Vector2) -> void:
	.move_on_map(new_cell - get_current_position())
	_board_manager.set_energy(new_cell, 3)
	_end_turn()

func _wait() -> void:
	_board_manager.get_cell(get_current_position()).get("energy_level") + 1
	_end_turn()


func _pulse() -> void:
	if health <= 60:
		$Label.set_text("No pulse, Energy low %s" % health)
		pass
	health -= 60
	$Label.set_text("pulse! %s" % health)
	
	var coord = get_current_position()
	for x in range(-_pulse_radius, _pulse_radius + 1):
		for y in range(-_pulse_radius, _pulse_radius + 1):
			var target = Vector2(coord.x + x, coord.y + y)
			var cell_data = _board_manager.get_cell(target)
			_board_manager.set_energy(target, 3 if cell_data.energy_level < 3 else cell_data.energy_level + 1)
		
		_end_turn()

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

	if _is_turn:
		if event.is_pressed() and not event.is_echo():
			if event.is_action("up") and _new_cell_up in _movable_cells:
				_move_to(_new_cell_up)
			elif event.is_action("down") and _new_cell_down in _movable_cells:
				_move_to(_new_cell_down)
			elif event.is_action("left") and _new_cell_left in _movable_cells:
				_move_to(_new_cell_left)
			elif event.is_action("right") and _new_cell_right in _movable_cells: 
				_move_to(_new_cell_right)
			elif event.is_action("pulse"):
				_pulse()
			elif event.is_action("wait"):
				_wait()
			start_turn()
			_animate()


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


func _end_turn() -> void:
	_is_turn = false
	_turn_manager.end_turn()

func set_health(value):
	health = value
	health = clamp(health, 0, _max_health)
