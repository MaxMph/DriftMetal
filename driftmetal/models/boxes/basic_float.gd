extends RigidBody3D

var time = 0
var depth
var float_strength = 6
var lin_drag = 0.02
var ang_drag = 0.02
var underwater = false



func _process(delta: float) -> void:
	time += 1 * delta

func _physics_process(delta: float) -> void:
	depth = get_sin(global_position.x) - global_position.y
	if depth > 0:
		apply_force(Vector3.UP * float_strength * depth, global_position - global_position)
		underwater = true
		#gravity_scale = 0.3
	else:
		underwater = false
		#gravity_scale = 1


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if underwater == true:
		state.linear_velocity *= 1 - lin_drag
		state.angular_velocity *= 1 - ang_drag

func get_sin(x):
	return sin(x * 0.2 + global_position.y * 0.2 + time) * 0.1;
