extends Control

@onready var int_cast = $"../../head_holder/sub_holder_1/sub_holder_2/head/Camera3D/interact_cast"

#@onready var bait = $bait
#@onready var prosthetics = $prosthetics

var Player

var wormcost = 2
var breadcost = 4
var sardinecost = 8

var legcost = 30


func _ready() -> void:
	Player = $"../.."


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shop") and Global.in_menu == false:
		if int_cast.is_colliding() and int_cast.get_collider().is_in_group("bait_shop"):
			if $bait.visible == false:
				bait_open()
			else:
				close()
		if int_cast.is_colliding() and int_cast.get_collider().is_in_group("prosthetics_shop"):
			if $prosthetics.visible == false:
				prosthetics_open()
			else:
				close()

	if Input.is_action_pressed("exit"):
		if $prosthetics.visible == true or $bait.visible == true:
			close()

func bait_open():
	print("bait")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$bait.visible = true
	Global.in_menu = true
	get_tree().paused = true
	$bait/HBoxContainer/bread/bread.grab_focus()
	print("focused")

func prosthetics_open():
	print("prosthetics")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$prosthetics.visible = true
	Global.in_menu = true
	get_tree().paused = true
	$"prosthetics/VBoxContainer/leftleg/left leg".grab_focus()



func close():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$prosthetics.visible = false
	$bait.visible = false
	get_tree().paused = false
	Global.in_menu = false
	


func _on_left_leg_pressed() -> void:
	if Global.money >= legcost:
		Global.money -= legcost
		Global.left_leg = true
		Player.legchange()


func _on_right_leg_pressed() -> void:
	if Global.money >= legcost:
		Global.money -= legcost
		Global.right_leg = true
		Player.legchange()


func _on_worm_pressed() -> void:
	print("works")
	if Global.money >= wormcost:
		Global.money -= wormcost
		Global.worms += 1


func _on_bread_pressed() -> void:
	if Global.money >= breadcost:
		Global.money -= breadcost
		Global.bread += 1


func _on_sardines_pressed() -> void:
	if Global.money >= sardinecost:
		Global.money -= sardinecost
		Global.sardines += 1
