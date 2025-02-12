extends RigidBody3D

var water_level = 0
var depth


var float_strength = 1
var lin_drag = 0.02
var ang_drag = 0.02
var underwater = false
var time = 0

@onready var markers = $CollisionShape3D.get_children()


func _process(delta: float) -> void:
	time += 1.0 * delta

func _physics_process(delta: float) -> void:
	#water_level = get_sin()
	#depth = (water_level + 0.5) - global_position.y
	
	#if depth > water_level:
		#underwater = true
		#apply_force(Vector3.UP * float_strength * depth, $CollisionShape3D/Marker3D.global_position)
		#apply_central_force(Vector3.UP * float_strength * depth)
	
	for m in markers:
		depth = get_sin(m.global_position.x) - m.global_position.y
		if depth > 0:
			apply_force(Vector3.UP * float_strength * depth, m.global_position - global_position)
	
	#depth1 = (get_sin($CollisionShape3D/Marker3D.global_position.y)) - $CollisionShape3D/Marker3D.global_position.y
	#depth2 = (get_sin()) - $CollisionShape3D/Marker3D2.global_position.y
	#depth3 = (get_sin()) - $CollisionShape3D/Marker3D3.global_position.y
	#depth4 = (get_sin()) - $CollisionShape3D/Marker3D4.global_position.y
	#
	#if depth1 > water_level:
		#apply_force(Vector3.UP * float_strength * depth, $CollisionShape3D/Marker3D.global_position)
	#if depth2 > water_level:
		#apply_force(Vector3.UP * float_strength * depth, $CollisionShape3D/Marker3D2.global_position)
	#if depth3 > water_level:
		#apply_force(Vector3.UP * float_strength * depth, $CollisionShape3D/Marker3D3.global_position)
	#if depth4 > water_level:
		#apply_force(Vector3.UP * float_strength * depth, $CollisionShape3D/Marker3D4.global_position)


func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	
	state.linear_velocity *= 1 - lin_drag
	state.angular_velocity *= 1 - ang_drag

func get_sin(x):
	return sin(x * 0.2 + global_position.y * 0.2 + time) * 0.1;
	
