extends Node
class_name RandFish

var fish1res = load("res://scripts/fish_resources/fish_1.tres")
var fish2res = "res://scripts/fish_resources/fish_2.tres"
var fish3res = "res://scripts/fish_resources/fish_3.tres"

@export var fish_list: Array[Resource] = []


func pick_random_fish(items_array: Array = fish_list):
	for item in items_array:
			item.pickable = false
	
	match Global.cur_bait:
		0:
			
			items_array[0].pickable = true
		1:
			items_array[0].pickable = true
			items_array[1].pickable = true
		2:
			items_array[0].pickable = true
			items_array[1].pickable = true
			items_array[2].pickable = true
		3:
			items_array[1].pickable = true
			items_array[2].pickable = true
	
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
