extends "res://src/Managers/BoardManager/Grid/ObjectGrid/ContainerGrid.gd"

const NO_MACHINE = 0

# Machine just keeps a list. They set their own blocking
func add_machine(machine_to_add: Node, map_position: Vector2) -> int:
	return add(machine_to_add, map_position)

func remove_machine(machine_id: int) -> void:
    var map_position = get_position_by_id(machine_id)
    remove(machine_id)
    _blocking_grid.set_cell_is_blocking(map_position, false)
    
func set_machine_blocking(id, is_blocking) -> void:
    var map_position = get_position_by_id(id)
    _blocking_grid.set_cell_is_blocking(map_position, is_blocking)
