extends Node
class_name RandFish

@export var fish_list: Array[Resource] = []


func pick_random_fish(items_array: Array = fish_list):
	var chosen_value = null
	if items_array.size() > 0:
		var overall_chance: int = 0
		for item in items_array:
			if item.pickable:
				overall_chance += item.pick_chance
		
		var random_number = randi() % overall_chance
		
		var offset: int = 0
		for item in items_array:
			if item.pickable:
				if random_number < item.pick_chance + offset:
					chosen_value = item.VALUE
					break
				else:
					offset += item.pick_chance
	return chosen_value
