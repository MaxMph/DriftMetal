extends Node3D



func cam_change_1():
	Global.in_menu = true
	$"../../../MeshInstance3D/ColorRect".hide()
	$cam1.make_current()
	Global.Player.hide()
	Global.Player.hide_ui()
	Global.Player.hide()



func cam_change_2():
	$cam2.make_current()
