extends Node

var left_leg = false
var right_leg = false

var hook = 100
var worms = 0
var bread = 0
var sardines = 0

var selected_bait = 0
var cur_bait
var max_select = 3

var in_menu = false

@export var Player: CharacterBody3D

var money = 0

func save_quit():
	var config = ConfigFile.new()
	#player pos and rot
	config.set_value("save", "player_pos", Player.global_position)
	config.set_value("save", "head_rot", Player.head.global_rotation)
	config.set_value("save", "cam_rot", Player.cam.global_rotation)
	
	#prosthetics
	config.set_value("save", "left_leg", left_leg)
	config.set_value("save", "right_leg", right_leg)
	
	#other
	config.set_value("save", "money", money)
	
	config.save("user://save.cfg")
	get_tree().quit()

	

func _load():
	var config = ConfigFile.new()
	var result = config.load("user://save.cfg")
	
	
	if result == OK:
		Player.global_position = config.get_value("save", "player_pos")
		Player.head.global_rotation = config.get_value("save", "head_rot")
		Player.cam.global_rotation = config.get_value("save", "cam_rot")
		
		left_leg = config.get_value("save", "left_leg")
		right_leg = config.get_value("save", "right_leg")
		
		money = config.get_value("save", "money")
		
	else:
		Player.play_comic()
	
	Player.legchange()
