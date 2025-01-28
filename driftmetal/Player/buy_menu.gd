extends Control

@onready var int_cast = $"../../head_holder/head/Camera3D/interact_cast"
@onready var Player = $"../.."

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shop"):
		if visible == false:
			open()
		else:
			close()
	
	if Input.is_action_pressed("exit") and visible:
		close()

func open():
	if int_cast.is_colliding() and int_cast.get_collider().is_in_group("shop"):
		get_tree().paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		visible = true

func close():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false
	get_tree().paused = false


func _on_left_leg_pressed() -> void:
	Global.left_leg = true
	Player.legchange()


func _on_right_leg_pressed() -> void:
	Global.right_leg = true
	Player.legchange()
