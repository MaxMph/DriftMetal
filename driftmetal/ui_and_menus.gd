extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("exit"):
		if $buy_menu.visible == false and $fish_caught.visible == false:
			if $pause_menu.visible == false:
				$pause_menu.visible = true
				get_tree().paused = true
				Input.MOUSE_MODE_VISIBLE
			else:
				$pause_menu.visible = false
				get_tree().paused = false
				Input.MOUSE_MODE_CAPTURED
