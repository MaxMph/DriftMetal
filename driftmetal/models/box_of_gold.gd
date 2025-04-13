extends StaticBody3D

@export var value = 20
@export var number = 1

func _ready() -> void:
	await get_tree().process_frame
	for i in Global.gold_found:
		if i != null:
			if i == number:
				turnoff()

func turnoff():
	remove_from_group("has_func")
	remove_from_group("interactable")
	$Cube/OmniLight3D.hide()

func interacted():
	Global.Player.coinsfound(value)
	Global.money += value
	remove_from_group("has_func")
	remove_from_group("interactable")
	$Control/Label.text = "$" + str(value)
	$AnimationPlayer.play("lightfade")
	Global.gold_found.append(number)
	print(Global.gold_found)
