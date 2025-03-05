extends Node

var talking = false
var playercam

func _process(delta: float) -> void:
	if talking:
		if Input.is_action_just_pressed("exit"):
			close()
		if Input.is_action_just_pressed("jump") and $"../dialouge".visible:
			if ($"../dialouge/AnimatedSprite2D".frame + 1) == $"../dialouge/AnimatedSprite2D".sprite_frames.get_frame_count("default"):
				close()
				
			else:
				$"../dialouge/AnimatedSprite2D".frame += 1

func interacted():
	playercam = Global.Player.cam
	talking = true
	Global.in_menu = true
	$"../Camera3D".current = true
	get_tree().paused = true
	$"../dialouge".visible = true

func close():
	talking = false
	playercam.current = true
	Global.in_menu = false
	get_tree().paused = false
	$"../dialouge".visible = false
	$"../dialouge/AnimatedSprite2D".frame = 0
