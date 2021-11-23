extends Machines
class_name Trigger

export (Array, NodePath) var _link_with_machines

var machine_list : Array

func _ready() -> void:
	for machine_path in _link_with_machines:
		machine_list.append(get_node(machine_path))

func start_turn() -> void:
	pass

func power_up_machines() -> void:
	for machine in  machine_list:
		machine.set_power_on(true)

func shut_down_machines() -> void:
	for machine in machine_list:
		machine.set_power_on(false)




