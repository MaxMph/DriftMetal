extends Node2D

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump") and $AnimatedSprite2D.is_playing() and !$AnimationPlayer.is_playing() :
		$AnimationPlayer.play("fade")

func _ready() -> void:
	visible = true
	$AnimatedSprite2D.play("default")
	
	#$AnimationPlayer.play("comic 1")
	$AnimationPlayer.play("fadein")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade":
		visible = false
		get_tree().paused = false




func _on_animated_sprite_2d_frame_changed() -> void:
	if $AnimatedSprite2D.frame == 7:
		$AnimationPlayer.play("fade")
