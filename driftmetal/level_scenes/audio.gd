extends Node




func _process(delta: float) -> void:
	if Global.play_oceansound and $oceansounds1.playing == false:
		$oceansounds1.play()
