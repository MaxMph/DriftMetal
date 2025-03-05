extends Node
var spots: Array = []
var dist = 1000
var strength
var rad_level = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spots = $spots.get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("rad_tracker") and Global.in_menu == false:
		$Control.visible = true
	else:
		$Control.visible = false

func find_spot(pos):
	dist = 1000
	strength = 0
	for s in spots:
		if (abs(s.global_position.x - pos.x) + abs(s.global_position.z - pos.z)) < dist:
			dist = (abs(s.global_position.x - pos.x) + abs(s.global_position.z - pos.z))
			strength = s.rad_strength
			$Control/VBoxContainer/rad_level.text = str(roundf(dist)) + "m"
			if  28 - roundf(dist) > 0:
				$Control/VBoxContainer/rad_strength.text = str((28 - roundf(dist)) * strength) 
				rad_level = (28 - roundf(dist)) * strength
			else:
				$Control/VBoxContainer/rad_strength.text = "0"
				rad_level = 1
