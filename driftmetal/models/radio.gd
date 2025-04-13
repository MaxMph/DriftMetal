extends StaticBody3D

var cur_song = 3
@onready var cur_player = $"../../songs/AudioStreamPlayer3D"
var off = false

func interacted():
	$"../../AudioStreamPlayer".play(0.1)
	switch()

func switch():
	
	cur_player.stop()
	
	cur_song += 1
	match cur_song:
		0:
			cur_player = $"../../songs/AudioStreamPlayer3D"
		1:
			cur_player = $"../../songs/AudioStreamPlayer3D2"
		2:
			cur_player = $"../../songs/AudioStreamPlayer3D3"
		3:
			off = true
		4:
			cur_song = 0
			cur_player = $"../../songs/AudioStreamPlayer3D"
	
	if off == false:
		cur_player.play()
	else:
		off = false


func _on_audio_stream_player_3d_finished() -> void:
	switch()


func _on_audio_stream_player_3d_2_finished() -> void:
	switch()


func _on_audio_stream_player_3d_3_finished() -> void:
	switch()
