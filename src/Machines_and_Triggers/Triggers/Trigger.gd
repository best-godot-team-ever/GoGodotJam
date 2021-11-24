extends MachineAndTrigger
class_name Trigger


var machine_conection_list : Array


func start_turn() -> void:
	pass

func feed_machines() -> void:
	for machine in  machine_conection_list:
		if ! machine.trigger_feeding_list.has(self):
			machine.trigger_feeding_list.append(self)

func dont_feed_machines() -> void:
	for machine in machine_conection_list:
		if machine.trigger_feeding_list.has(self):
			machine.trigger_feeding_list.erase(self)






