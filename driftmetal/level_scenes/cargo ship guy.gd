extends Node3D

var talking = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_parent().look_at(Global.Player.global_position)
	get_parent().rotation.x = 0
	
	if talking:
		if Input.is_action_just_pressed("exit"):
			close()
	if Input.is_action_just_pressed("jump") and talking and $dialouge/HBoxContainer.visible == false:
		$dialouge/HBoxContainer.visible = true
		$dialouge/Sprite2D2.visible = false
		$dialouge/Sprite2D3.visible = true


func interacted():
	Global.Player.can_cast = false
	talking = true
	Global.in_menu = true
	get_tree().paused = true
	$dialouge.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	$dialouge/HBoxContainer.visible = false
	$dialouge/Sprite2D2.visible = true
	$dialouge/Sprite2D3.visible = false

func close():
	talking = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.in_menu = false
	get_tree().paused = false
	$dialouge.visible = false
	
	await get_tree().create_timer(0.1).timeout
	Global.Player.can_cast = true



func _on_decline_pressed() -> void:
	close()


func _on_pay_pressed() -> void:
	if Global.money >= 600:
		Global.money -= 600
		close()
		$"../../cutscene controller/AnimationPlayer".play("cutscene")
