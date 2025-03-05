extends StaticBody3D

var cur_song = 0
@onready var cur_player = $"../../songs/AudioStreamPlayer3D"
var off = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func interacted():
	
	$"../../AudioStreamPlayer".play(0.1)
	
	print("wefaerghtjy")
	#$"../../songs/AudioStreamPlayer3D". stream_count
	#$"../../AudioStreamPlayer3D".get_stream_playback().switch_to_clip(2)
	
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
