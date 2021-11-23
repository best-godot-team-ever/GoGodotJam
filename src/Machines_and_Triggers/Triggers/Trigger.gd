extends Machines
class_name Trigger

export (Array, PackedScene) var _link_with_machines

func start_turn() -> void:
	pass

func power_up_machines() -> void:
	for machine in _link_with_machines:
		machine.set_power_on(true)

func shut_down_machines() -> void:
	for machine in _link_with_machines:
		machine.set_power_on(false)




