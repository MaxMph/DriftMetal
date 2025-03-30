extends Control


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	#print(Input.mouse_mode)
	if Input.is_action_just_pressed("exit"):
		if visible == false and Global.in_menu == false:
			open()
		elif visible:
			close()


func open():
	Global.in_menu = true
	visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func close():
	Global.in_menu = false
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_resume_pressed() -> void:
	await get_tree().create_timer(0.1).timeout
	close()


func _on_exit_pressed() -> void:
	Global.save_quit()


func _on_button_pressed() -> void:
	visible = false
	$"../settings".open()
