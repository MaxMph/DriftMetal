extends CharacterBody3D


var SPEED = 5.0
var JUMP_VELOCITY = 4.5

var sense = 0.001

var acc = 20
var fric = 20

@onready var head_holder = $head_holder
@onready var head: Node3D = $head_holder/head
@onready var cam = $head_holder/head/Camera3D
@onready var int_cast: RayCast3D = $head_holder/head/Camera3D/interact_cast

@onready var lure_spawn = $"head_holder/head/Camera3D/fishing rod/lure_marker"
@onready var lure = preload("res://Player/lure.tscn")
@onready var rope = $"head_holder/head/Camera3D/fishing rod/lure_marker/rope"
var cast_strength = 0
var cur_lure
var casted = false

var legspeed
var leftarm
var rightarm

func _ready() -> void:
	legchange()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:


	if not is_on_floor():
		velocity += get_gravity() * delta


	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * SPEED, acc * delta)
		velocity.z = move_toward(velocity.z, direction.z * SPEED, acc * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, fric * delta)
		velocity.z = move_toward(velocity.z, 0, fric * delta)

	if Input.is_action_pressed("cast"):
		cast_strength = move_toward(cast_strength, 8, 6 * delta)
	
	if Input.is_action_just_released("cast"):
		cast()
	
	#if Input.is_action_just_pressed("cast"):
	#	cast()

	if casted == true:
		line(cur_lure.global_position)
		rope.visible = true
	
	move_and_slide()

func	_unhandled_input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * sense)
			cam.rotate_x(-event.relative.y * sense)
			cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func legchange():
	print("legsshdfjasrg")
	legspeed = 0
	if Global.left_leg == true:
		$"UI and Menus/limb_UI/BaseLimbUi1/Leg1".visible = true
		$"UI and Menus/buy_menu/left leg".disabled = true
		legspeed += 3
	if Global.right_leg == true:
		$"UI and Menus/limb_UI/BaseLimbUi1/Leg2".visible = true
		$"UI and Menus/buy_menu/right leg".disabled = true
		legspeed += 3
	# the 6 is temp, replace with 1
	SPEED = 1 + legspeed
	if Global.right_leg == false and Global.left_leg == false:
		head_holder.position = $cam_pos/Marker_2.position
	else:
		head_holder.position = $cam_pos/Marker_1.position

func cast():
	var inst = lure.instantiate()
	if cur_lure != null:
		casted = false
		print("deleating")
		cur_lure.queue_free()
	get_parent().add_child(inst)
	inst.global_position = lure_spawn.global_position
	inst.global_rotation.y = cam.global_rotation.y
	inst.apply_central_impulse(-cam.global_transform.basis.z * cast_strength)
	cur_lure = inst
	print(cur_lure)
	cast_strength = 0
	casted = true
	#line(cur_lure.position)

func line(lure_point: Vector3):
	var dist = lure_spawn.global_position.distance_to(lure_point)
	
	rope.look_at(lure_point)
	rope.scale = Vector3(1, 1, dist)
	#var mesh_inst = MeshInstance3D.new()
	#var immediate_mesh = ImmediateMesh.new()
	#var material = ORMMaterial3D.new()
	#
	#mesh_inst.mesh = immediate_mesh
	#mesh_inst.cast_shadow = false
	#
	#immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	#immediate_mesh.surface_add_vertex(lure_spawn.position)
	#immediate_mesh.surface_add_vertex(lure_point)
	#immediate_mesh.surface_end()
	#
	#material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	#material.albedo_color = Color.WHITE
