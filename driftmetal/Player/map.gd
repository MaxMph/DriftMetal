extends Control


func _process(delta: float) -> void:
	if Input.is_action_pressed("map") and Global.in_menu == false:
		visible = true
	else:
		visible = false
