extends "res://src/Entity/Enemy/Enemy.gd"

enum GrabberState {PoweredOff, Idle, Chasing}

var current_state: int = GrabberState.PoweredOff

func start_turn() -> void:
    match current_state:
        GrabberState.PoweredOff:
            if _board_manager.get_cell(get_current_position()).energy_level > 0:
                current_state = GrabberState.Idle
                # Play Power on Animation?
        GrabberState.Idle:
            if _board_manager.get_cell(get_current_position()).energy_level > 0:
                current_state = GrabberState.Chasing
        GrabberState.Chasing:
            if _board_manager.get_cell(get_current_position()).energy_level == 0:
                current_state = GrabberState.PoweredOff
                # Play Powered off Animation

            else:
                # I have power so I should move one tile towards the player's current position
                _move_towards_player()
    $Label.set_text(GrabberState.keys()[current_state])

func _move_towards_player() -> void:
    var player_coord = _board_manager.get_entity_position_by_id(_turn_manager.player_entity_id)
    var offset = player_coord - get_current_position()

    var direction = Vector2()
    if abs(offset.x) >= abs(offset.y):
        direction.x = sign(offset.x)
    else:
        direction.y = sign(offset.y)
    
    move_on_map(direction)