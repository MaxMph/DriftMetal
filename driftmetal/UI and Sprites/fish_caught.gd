extends Control

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit") and visible == true:
		close()

func open():
	$VBoxContainer/value.text = "$" + str(Global.Player.fish_value)
	get_tree().paused = true
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Global.in_menu = true

func close():
	get_tree().paused = false
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	await get_tree().create_timer(0.1).timeout
	$"../..".can_cast = true
	Global.in_menu = false
	Global.money += Global.Player.fish_value


func _on_continue_button_up() -> void:
	close()
