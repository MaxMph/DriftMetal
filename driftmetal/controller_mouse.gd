extends Node2D


func _process(delta: float) -> void:
	
	var axis_vector = Vector2.ZERO
	axis_vector.x = Input.get_action_strength("look_right") - Input.get_action_strength("look_left")
	axis_vector.y = Input.get_action_strength("look_down") - Input.get_action_strength("look_up")
	if InputEventJoypadMotion:
		if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED and axis_vector != Vector2.ZERO:
			var new_mousepos = get_global_mouse_position() + axis_vector * 6
			Input.warp_mouse(new_mousepos)
	
	if Input.is_action_just_pressed("gamepad_select") and Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		var a = InputEventMouseButton.new()
		a.position = get_global_mouse_position()
		a.button_index = MOUSE_BUTTON_LEFT
		a.pressed = true
		Input.parse_input_event(a)
		await get_tree().process_frame
		a.pressed = false
		Input.parse_input_event(a)
		
		
