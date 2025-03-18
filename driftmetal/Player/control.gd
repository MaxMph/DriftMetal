extends Control

var cam_rot_affect

var map_open

func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	$"fps label".text = "FPS: " + str(Engine.get_frames_per_second())
	$Money.text = "$" + str(Global.money)
	
	
	cam_rot_affect = deg_to_rad($"../../head_holder/sub_holder_1/sub_holder_2/head/Camera3D".rotation.x) * 10000 + 140 #+ (abs($"../hand/TextureRect3".scale.y) * 40)
	$"../hand".position.y = cam_rot_affect + 20
	if scale.y > 0.2:
		$"../hand/TextureRect3".scale.y = 0.9 - cam_rot_affect * 0.0005
	else:
		$"../hand/TextureRect3".scale.y = 0.2
		
	#if $"../hand".position.y < 100:
	#	$"../hand".position.y = 100
	
