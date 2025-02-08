extends RigidBody3D

var water_level = -0.05
var depth
var float_strength = 4
var lin_drag = 0.02
var ang_drag = 0.02
var underwater = false


var player


@onready var ocean = $"../MeshInstance3D"



func _process(delta: float) -> void:
	water_level = ocean.get_wave(global_position.x, global_position.z)
	#global_position.y = water_level
	depth = water_level - global_position.y
	if depth > water_level:
		underwater = true
		apply_central_force(Vector3.UP * float_strength * depth)
	else:
		underwater = false

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if underwater == true:
		state.linear_velocity *= 1 - lin_drag
		state.angular_velocity *= 1 - ang_drag
