extends Node

var talking = false
var playercam



func _process(delta: float) -> void:
	if talking:
		if Input.is_action_just_pressed("exit"):
			close()

func interacted():
	Global.Player.can_cast = false
	playercam = Global.Player.cam
	talking = true
	Global.in_menu = true
	$"../Camera3D".current = true
	get_tree().paused = true
	$"../dialouge".visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func close():
	talking = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	playercam.current = true
	Global.in_menu = false
	get_tree().paused = false
	$"../dialouge".visible = false
	await get_tree().create_timer(0.1).timeout
	Global.Player.can_cast = true



func _on_decline_pressed() -> void:
	pass # Replace with function body.


func _on_pay_pressed() -> void:
	if Global.money >= 100:
		Global.money -= 100
		travel()
		#$"../ColorRect/AnimationPlayer2".play("fade_out")

func travel():
	Global.Player.global_position = $"../boat_point".global_position
	Global.Player.velocity = Vector3.ZERO
	close()
	$"../../../Path3D".start()
	#$"../ColorRect/AnimationPlayer2".play("fade_in")
	
