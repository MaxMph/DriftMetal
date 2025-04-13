extends Control


func _ready() -> void:
	$VBoxContainer/Start_Button.grab_focus()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://level_scenes/world.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_button_pressed() -> void:
	DirAccess.remove_absolute("user://save.cfg")
	get_tree().change_scene_to_file("res://level_scenes/world.tscn")
