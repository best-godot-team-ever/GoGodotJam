extends Resource
class_name TurnManager

var enemies: Array
var machines: Array
var player


func end_turn() -> void:
	machines.sort_custom(self,"_sort")
	for machine in machines :
		machine.start_turn()
		yield(machine.start_turn(), "completed")
	
	enemies.sort_custom(self,"_sort")
	for enemy in enemies :
		enemy.start_turn()
		yield(enemy.start_turn(), "completed")
	
	player.start_turn()

func _sort(entity1, entity2) -> bool:
	return entity1.turn_speed > entity2.turn_speed

# Objects that inherit from Enemy and Machine Classes, already append themselves when ready to the enemies and machines array.
# they also have the tuen manager preloaded. But they need to have in their start_turn() method a yield() (you can always use yield(get_tree().create_timer(0.0), "timeout"))

