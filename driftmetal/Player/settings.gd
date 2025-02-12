extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.sense = $VBoxContainer/HSlider.value * 0.001


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit") and visible:
		close()

func open():
	visible = true
	get_tree().paused = true
	Global.in_menu = true


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
