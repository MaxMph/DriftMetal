extends Node


@onready var cam = $"../head_holder"
@onready var rod = $"../head_holder/sub_holder_1/sub_holder_2/head/Camera3D/fishing rod"
@onready var player = $".."

#@export var period = 0.3
#@export var magnitude = 0
#@export var mag_sub = 0.01

var initial_transform
var initial_rod_transform

@export var noise_speed = 50.0
@export var noise : FastNoiseLite
@export var mag_mult = 0.03

@export var max_x = 0.0012
@export var max_y = 0.0012
@export var max_z = 0.0006

@export var Rmax_x = 0.012
@export var Rmax_y = 0.012
@export var Rmax_z = 0.006

var initial_rot
var mag = 0
var mag2 = 0

@export var min_mag = 0.004

var time = 0.0

func _ready() -> void:
	initial_rot = cam.rotation

func _process(delta: float) -> void:
	time += delta
	#var initial_transform = cam.transform 
	#var elapsed_time = 0.0

	#while elapsed_time < period:
		#var offset = Vector3(
			#randf_range(-magnitude, magnitude),
			#randf_range(-magnitude, magnitude),
			#0.0
		#)
	if player.fish_on:
		mag = (player.line_strength.value / player.line_strength.max_value)
		mag2 = (player.line_strength.value / player.line_strength.max_value) - 0.2
		#noise_speed * (mag + 0.4)
		
		if player.line_strength.value / player.line_strength.max_value > 0.2:
			cam.rotation.x = initial_rot.x + max_x * shake_str2() * noise_value(0)
			cam.rotation.y = initial_rot.y + max_y * shake_str2() * noise_value(1)
			cam.rotation.z = initial_rot.z + max_z * shake_str2() * noise_value(2)
		
		rod.rotation.x = initial_rot.x + Rmax_x * shake_str() * noise_value(3)
		rod.rotation.y = initial_rot.x + Rmax_x * shake_str() * noise_value(4)
		rod.rotation.z = initial_rot.x + Rmax_x * shake_str() * noise_value(5)
		
		#initial_transform = cam.transform
		#initial_rod_transform = rod.transform
		#if (((player.line_strength.value / player.line_strength.max_value) * mag_mult) - mag_sub) > 0:
			#magnitude = ((player.line_strength.value / player.line_strength.max_value) * mag_mult) - mag_sub
			#print(magnitude)
		#else:
			#magnitude = 0
		#var offset = Vector3(
			#randf_range(-magnitude, magnitude),
			#randf_range(-magnitude, magnitude),
			#0.0
			#)
		#cam.transform.origin = initial_transform.origin + offset
		#rod.transform.origin = initial_rod_transform.origin + offset
		#await get_tree().process_frame
		#cam.transform = initial_transform
		#rod.transform = initial_rod_transform
	
	else:
		cam.rotation = initial_rot

func shake():
	pass
	#initial_transform = cam.transform

func shake_str() -> float:
	return mag * mag

func shake_str2() -> float:
	return mag2 * mag2

func noise_value(_seed: int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)
	
