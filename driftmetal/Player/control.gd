extends Control



func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	$"fps label".text = "FPS: " + str(Engine.get_frames_per_second())
	$Money.text = "$" + str(Global.money)
