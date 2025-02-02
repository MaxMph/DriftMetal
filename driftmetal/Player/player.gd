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
var fish_on = false
var can_cast = true
var time = 0
var pull_force = 0


#fish_stuff
var fish = 1
var fish_strength = 0.6
var fish_value = 10
@onready var fish_display = $"UI and Menus/fish_caught/VBoxContainer/SubViewportContainer/SubViewport/fish_display"



# rod ui stuff
@onready var catch_prog = $"UI and Menus/rod_hud/ProgressBar"
@onready var fish_pull = $"UI and Menus/rod_hud/fishpull"
@onready var line_strength = $"UI and Menus/rod_hud/line_strength"

var bait_str

var legspeed
var leftarm
var rightarm


func _ready() -> void:
	Global.Player = self
	legchange()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta


	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if Global.left_leg == true or Global.right_leg == true:
			if Global.left_leg == true and Global.right_leg == true:
				velocity.y = JUMP_VELOCITY + 2
			else:
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
	
	if Input.is_action_just_released("cast") and can_cast:
		match Global.selected_bait:
			0:
				cast()
			1:
				if Global.worms != 0:
					Global.worms -= 1
					cast()
				else:
					cast_strength = 0
			2:
				if Global.bread != 0:
					Global.bread -= 1
					cast()
				else:
					cast_strength = 0
			3:
				if Global.sardines != 0:
					Global.sardines -= 1
					cast()
				else:
					cast_strength = 0
	
	#if Input.is_action_just_pressed("cast"):
	#	cast()

	if casted == true:
		line(cur_lure.global_position)
		rope.visible = true
	
	if Input.is_action_pressed("reel") and fish_on:
		pull_force += 3 * delta
	elif fish_on:
		pull_force = -4 * delta

	
	if fish_on:
		if line_strength.value >= line_strength.max_value:
			fish_off()
		
		fish_pull.value =  sin(time) * 10 #((sin(time) + 1) * 0.5) * 100
		
		line_strength.value += (pull_force + fish_pull.value * 0.03)
		catch_prog.value += (line_strength.value - (line_strength.max_value * fish_strength)) * 0.1
		
		if catch_prog.value >= catch_prog.max_value -  0.5:
			fish_caught()
			catch_prog.value = 0
	
	
	move_and_slide()

func _process(delta: float) -> void:
	if fish_on:
		time += delta
	else:
		time = 0

func	_unhandled_input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * sense)
			cam.rotate_x(-event.relative.y * sense)
			cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func legchange():
	legspeed = 0
	if Global.left_leg == true:
		$"UI and Menus/limb_UI/BaseLimbUi1/Leg1".visible = true
		$"UI and Menus/buy_menu/prosthetics/VBoxContainer/leftleg/left leg".disabled = true
		legspeed += 3
	if Global.right_leg == true:
		$"UI and Menus/limb_UI/BaseLimbUi1/Leg2".visible = true
		$"UI and Menus/buy_menu/prosthetics/VBoxContainer/rightleg/right leg".disabled = true
		legspeed += 3
	# the 6 is temp, replace with 1
	SPEED = 1 + legspeed
	if Global.right_leg == false and Global.left_leg == false:
		head_holder.position = $cam_pos/Marker_2.position
	else:
		head_holder.position = $cam_pos/Marker_1.position

func cast():
	Global.cur_bait = Global.selected_bait
	var inst = lure.instantiate()
	if cur_lure != null:
		fish_off()
	get_parent().add_child(inst)
	inst.global_position = lure_spawn.global_position
	inst.global_rotation.y = cam.global_rotation.y
	inst.apply_central_impulse(-cam.global_transform.basis.z * cast_strength)
	inst.player = self
	cur_lure = inst
	cast_strength = 0
	casted = true
	
	#line(cur_lure.position)

func line(lure_point: Vector3):
	var dist = lure_spawn.global_position.distance_to(lure_point)
	rope.visible = true
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

func find_waittime():
	return 4.0

func fish_on_hook():
	fish_on = true
	catch_prog.visible = true
	find_fish()

func fish_off():
	fish_on = false
	casted = false

	cur_lure.queue_free()
	rope.visible = false
	
	#ui rod stuff
	line_strength.value = line_strength.min_value
	fish_pull.value = 0
	pull_force = 0
	catch_prog.value = 0
	catch_prog.visible = false

func fish_caught():
	fish_off()
	can_cast = false
	$"UI and Menus/fish_caught".open()

func find_fish():
	fish = Callable(self, $RandFish.pick_random_fish())
	fish.call()

func fish_1():
	fish_strength = 0.4
	fish_value = randi_range(4, 8)
	fish_display.fish_vis("fish_1")
	print("fish_1")

func fish_2():
	fish_strength = 0.6
	fish_value = randi_range(10, 16)
	fish_display.fish_vis("fish_2")
	print("fish_2")

func fish_3():
	fish_strength = 0.8
	fish_value = randi_range(20, 30)
	fish_display.fish_vis("fish_3")
	print("fish_3")
