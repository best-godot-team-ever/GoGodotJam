extends MachineAndTrigger
class_name Machine

export (Array, NodePath) var _link_with_triggers

var trigger_feeding_list : Array = []

func _ready() -> void:
	for trigger_path in _link_with_triggers:
		var trigger = get_node(trigger_path)
		trigger.machine_conection_list.append(self)

func start_turn() -> void:
	if ! trigger_feeding_list.empty():
		pass
	if trigger_feeding_list.empty():
		pass
		
		



