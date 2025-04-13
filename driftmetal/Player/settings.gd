extends Control


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit") and visible:
		close()

func open():
	$VBoxContainer/HSlider.value = Global.sense * 1000
	visible = true
	get_tree().paused = true
	Global.in_menu = true
	$VBoxContainer/exit.grab_focus()


func close():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false
	Global.in_menu = false

func _on_fullscreen_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	get_tree().paused = true


func _on_unfullscreen_pressed() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	get_tree().paused = true


func _on_h_slider_value_changed(value: float) -> void:
	Global.sense = $VBoxContainer/HSlider.value * 0.001
	print(Global.sense)





func _on_exit_button_up() -> void:
	await get_tree().create_timer(0.1).timeout
	close()
