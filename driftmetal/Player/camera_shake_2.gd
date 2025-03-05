extends Node

@onready var cam = $"../head_holder"

@export var period = 0.1
@export var reduce = 0.6
@export var base_magnitude = 0.2
var magnitude = 0

@export var max_x = 0.0012
@export var max_y = 0.0012
@export var max_z = 0.0006

var time = 0.0
var start_time = 0
var initial_rot
var can_shake = false

@export var noise_speed = 50.0
@export var noise : FastNoiseLite

func _process(delta: float) -> void:
	time += delta
	
	if start_time + period > time and can_shake:
		cam.rotation.x = initial_rot.x + magnitude * noise_value(0)
		cam.rotation.y = initial_rot.y + magnitude * noise_value(1)
		cam.rotation.z = initial_rot.z + magnitude * noise_value(2)
	elif can_shake and magnitude > 0:
		magnitude -= reduce * delta
		cam.rotation.x = initial_rot.x + magnitude * noise_value(0)
		cam.rotation.y = initial_rot.y + magnitude * noise_value(1)
		cam.rotation.z = initial_rot.z + magnitude * noise_value(2)


func _shake():
	can_shake = true
	initial_rot = cam.rotation
	start_time = time
	magnitude = base_magnitude
	

func noise_value(_seed: int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)
