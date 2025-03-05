extends AudioStreamPlayer

@onready var timer = $Timer
var num = 0



func coin_sounds(value):
	await get_tree().create_timer(0.4).timeout
	if value < 10:
		num = 1
	else:
		num = floori(value / 10)
	
	play()
	$Timer.start()

func _on_timer_timeout() -> void:
	print("works")
	num -= 1
	if num > 0:
		play()
		$Timer.start()
