extends MeshInstance3D


@onready var water = preload("res://textures/shaders/water stuff/water_sinesum.tres")
var time = 0
var squish = 1.0
var wave_strength = 0.2
#var wave_scale = 0
#var time_scale = 2
#var height

var player


func _process(delta: float) -> void:
	#print(height)
	#get_wave(0)
	time += delta
	water.set_shader_parameter("time", time) 
	

func get_wave(x: float, z: float):
	#var noise_value = texture(water.get_shader_parameter("noise_texture"), global_position * wave_scale).r;
	#var noise = FastNoiseLite #water.get_shader_parameter("noise_texture")
	#var noise_value = noise.get (x * wave_scale, z * wave_scale) * 0.5 + 0.5
	
	return sin(x * squish + time) * wave_strength
	sin(global_position.x * squish + global_position.y * squish + time) * wave_strength;


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player = body
		$Area3D/AnimationPlayer.play("die")

func respawn():
	player.global_position = $Marker3D.global_position
