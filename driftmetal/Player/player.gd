extends CharacterBody3D


var SPEED = 5.0
var JUMP_VELOCITY = 4.5


var acc = 20
var fric = 20
var base_fric = 20

@onready var head_holder = $head_holder
@onready var head: Node3D = $head_holder/sub_holder_1/sub_holder_2/head
@onready var cam = $head_holder/sub_holder_1/sub_holder_2/head/Camera3D
@onready var int_cast: RayCast3D = $head_holder/sub_holder_1/sub_holder_2/head/Camera3D/interact_cast

@onready var lure_spawn = $"head_holder/sub_holder_1/sub_holder_2/head/Camera3D/fishing rod/fishing rod subholder/lure_marker"
@onready var lure = preload("res://Player/lure.tscn")
@onready var rope = $"head_holder/sub_holder_1/sub_holder_2/head/Camera3D/fishing rod/fishing rod subholder/lure_marker/rope"
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

var has_rad
var randrad = 0
var radmult = 1


# rod ui stuff
@onready var catch_prog = $"UI and Menus/rod_hud/ProgressBar"
@onready var fish_pull = $"UI and Menus/rod_hud/fishpull"
@onready var line_strength = $"UI and Menus/rod_hud/line_strength"

var bait_str

var legspeed
var leftarm
var rightarm

var walkspeed = 1.0
var landed = true
@onready var cam_player = $head_holder/sub_holder_1/sub_holder_2/head/Camera3D/cam_player
@onready var cam_player_2 = $"head_holder/sub_holder_1/sub_holder_2/head/Camera3D/cam_player 2"


#sound stuff
#var whoosh_volume = -10


func _ready() -> void:
	Global.Player = self
	legchange()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	$"../fishrad".find_spot(global_position)
	
	if not is_on_floor():
		fric = base_fric / 4
		landed = false
		velocity += get_gravity() * delta

	if is_on_floor():
		if landed == false:
			fric = base_fric
			cam_player_2.play("land")
			landed = true


	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if Global.left_leg == true or Global.right_leg == true:
			if Global.left_leg == true and Global.right_leg == true:
				velocity.y = JUMP_VELOCITY + 2
			else:
				velocity.y = JUMP_VELOCITY


	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity = velocity.move_toward(Vector3(direction.x * SPEED, velocity.y, direction.z * SPEED), acc * delta)
		$"UI and Menus/hand/AnimationPlayer".speed_scale = 0.8
		$"UI and Menus/hand/AnimationPlayer".play("crawl_2")
		
		if is_on_floor() and cam_player.current_animation != "land" :
			cam_player.speed_scale = velocity.length() / SPEED
			if legspeed != 0:
				cam_player.play("walk")
			else:
				cam_player.play("crawl")
		else:
			cam_player.speed_scale = 1
			cam_player.pause()
	else:
		cam_player.speed_scale = 1
		cam_player.pause()
		velocity = velocity.move_toward(Vector3(0, velocity.y, 0), fric * delta)
		
		#$"UI and Menus/hand/AnimationPlayer".speed_scale = 2

	if $ground_cast.is_colliding() and $ground_cast.get_collider().is_in_group("moving"):
		global_position = global_position + $"../Path3D".pos_dif
		print($"../Path3D".pos_dif)



	if Input.is_action_pressed("cast"):
		cast_strength = move_toward(cast_strength, 8, 6 * delta)
		$audio/beeeep.pitch_scale = 0.6 + cast_strength * 0.04
		$audio/beeeep.volume_db = -20 + cast_strength
		if $audio/beeeep.playing == false:
			$audio/beeeep.play()
	
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
		
		#audio
		#$"audio/line reeling".pitch_scale = 0.8 + (line_strength.value / 100)
		#if $"audio/line reeling".playing == false:
		#	$"audio/line reeling".play()
		#	$"audio/line running".stream_paused = true
	elif fish_on:
		pull_force = -4 * delta
		#$"audio/line running".play()
		#$"audio/line reeling".stop()
	#else:
		#$"audio/line running".stream_paused = true
		#$"audio/line reeling".stop()
	
	if Input.is_action_just_pressed("reel") and fish_on == false:
		if casted:
			match Global.selected_bait:
				0:
					pass
				1:
					Global.worms += 1
				2:
					Global.bread += 1
				3:
					Global.sardines += 1
			fish_off()
	
	if fish_on:
		if line_strength.value >= line_strength.max_value:
			fish_off()
		
		fish_pull.value =  sin(time) * 10 #((sin(time) + 1) * 0.5) * 100
		
		line_strength.value += (pull_force + fish_pull.value * 0.03)
		catch_prog.value += (line_strength.value - (line_strength.max_value * fish_strength)) * 0.1
		
		if catch_prog.value >= catch_prog.max_value -  0.5:
			fish_caught()
			catch_prog.value = 0
		
		#audio
		$"audio/line reeling".pitch_scale = 0.6 + (line_strength.value / 100)
		$"audio/line reeling".volume_db = -20 + (line_strength.value / 5)
		if $"audio/line reeling".playing == false:
			$"audio/line reeling".play()
	else:
		$"audio/line reeling".stop()
	
	move_and_slide()

func _process(delta: float) -> void:
	if fish_on:
		time += delta
	else:
		time = 0

func	_unhandled_input(event: InputEvent) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			head.rotate_y(-event.relative.x * Global.sense)
			cam.rotate_x(-event.relative.y * Global.sense)
			cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func legchange():
	legspeed = 0
	if Global.left_leg == true:
		$"UI and Menus/limb_UI/BaseLimbUi1/Leg1".visible = true
		$"UI and Menus/buy_menu/prosthetics/VBoxContainer/leftleg/left leg".disabled = true
		legspeed += 3
		$"UI and Menus/hand".visible = false
	if Global.right_leg == true:
		$"UI and Menus/limb_UI/BaseLimbUi1/Leg2".visible = true
		$"UI and Menus/buy_menu/prosthetics/VBoxContainer/rightleg/right leg".disabled = true
		legspeed += 3
		$"UI and Menus/hand".visible = false
	# the 6 is temp, replace with 1
	SPEED = 1.5 + legspeed
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
	$audio/beeeep.stop()
	$audio/whoosh.volume_db = -20 + cast_strength * 2
	$audio/whoosh.pitch_scale = 1 + cast_strength * 0.01
	$audio/whoosh.play()
	cast_strength = 0
	casted = true
	#cur_lure.fish_wait(6)
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

#func find_waittime():
#	return 4.0

func fish_on_hook():
	$camera_shake.shake()
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
	$audio/fish_caught.play()
	$camera_shake_2._shake()
	$audio/coin.coin_sounds(fish_value)
	$"UI and Menus/fish_caught".open()

func find_fish():
	rad_fish_chance()
	fish = Callable(self, $RandFish.pick_random_fish())
	fish.call()

func fish_1():
	fish_strength = 0.4
	fish_value = roundi(randi_range(4, 8) * radmult)
	fish_display.fish_vis("fish_1")
	print("fish_1")

func fish_2():
	fish_strength = 0.6
	fish_value = roundi(randi_range(12, 18) * radmult)
	fish_display.fish_vis("fish_2")
	print("fish_2")

func fish_3():
	fish_strength = 0.72
	fish_value = roundi(randi_range(24, 38) * radmult)
	fish_display.fish_vis("fish_3")
	print("fish_3")

func play_comic():
	$"UI and Menus/comic".visible = true
	Global.in_menu = true
	get_tree().paused = true

func rad_fish_chance():
	has_rad = false
	var subview = $"UI and Menus/fish_caught/VBoxContainer/SubViewportContainer/SubViewport".world_3d.environment
	radmult = 1
	subview.adjustment_brightness = 1
	subview.adjustment_contrast = 1
	subview.adjustment_saturation = 1
	var color_effect = ($"../fishrad".rad_level / 200)
	randrad = randi_range(0, 100)
	print(color_effect)
	if randrad < $"../fishrad".rad_level:
		print("rad fish")
		has_rad = true
		radmult =  1 + ($"../fishrad".rad_level / 80)
		subview.adjustment_brightness = 1 + color_effect
		subview.adjustment_contrast = 1 + color_effect
		subview.adjustment_saturation = 1 + color_effect * (7)
