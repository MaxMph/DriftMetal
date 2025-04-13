extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump") and $comic_ani.is_playing() and !$fade_ani_player.is_playing():
		$fade_ani_player.play("fade")

func _ready() -> void:
	visible = true
	$comic_ani.play("default")
	
	#$AnimationPlayer.play("comic 1")
	$fade_ani_player.play("fadein")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade":
		Global.in_menu = false
		visible = false
		get_tree().paused = false
		$comic_ani.stop()
		Global.play_oceansound = true
		





func _on_animated_sprite_2d_frame_changed() -> void:
	if $comic_ani.frame == 7:
		$fade_ani_player.play("fade")
