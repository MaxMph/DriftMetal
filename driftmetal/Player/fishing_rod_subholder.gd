extends Node3D

var start_pos
var start_rot
var moving = false
var casting = false

func _ready() -> void:
	start_pos = position.z
	start_rot = rotation.x

func _process(delta: float) -> void:
	if Input.is_action_pressed("cast"):
		position.z = start_pos + (Global.Player.cast_strength * 0.01)
		rotation.x = start_rot + (Global.Player.cast_strength * 0.01)
		casting = true
	elif casting:
		#position.z = start_pos
		position.z = move_toward(position.z, start_pos, 1 * delta)
		rotation.x = move_toward(rotation.x, start_pos, 1 * delta)
		if position.z == start_pos and rotation.x == start_rot:
			casting = false
