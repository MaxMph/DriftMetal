extends RayCast3D


func _physics_process(delta: float) -> void:
	if is_colliding() and get_collider().is_in_group("interactable"):
		
		#reset vis to default
		$"../../../../../../UI and Menus/Control/crosshair".visible = true
		$"../../../../../../UI and Menus/Control/crosshair/F".visible = true
		$"../../../../../../UI and Menus/Control/crosshair/B".visible = false
		
		if get_collider().is_in_group("bait_shop") or get_collider().is_in_group("prosthetics_shop"):
			$"../../../../../../UI and Menus/Control/crosshair/B".visible = true
		
		if get_collider().is_in_group("climbable"):
			$"../../../../../../UI and Menus/Control/crosshair/F".visible = false
			if Input.is_action_pressed("up"):
				Global.Player.velocity.y = 4
			
		if Input.is_action_just_pressed("interact") and get_collider().is_in_group("has_func"):
			print("works")
			get_collider().interacted()
			
	
	else:
		$"../../../../../../UI and Menus/Control/crosshair".visible = false
	
	if Global.in_menu == true:
		$"../../../../../../UI and Menus/Control/crosshair".visible = false
