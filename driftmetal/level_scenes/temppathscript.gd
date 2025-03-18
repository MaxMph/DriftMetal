extends Path3D

var started = true 
var pos_dif = Vector3.ZERO
var last_pos = Vector3.ZERO
var speed = 0.1
var max_speed = 0.1
var acc = 0.04

func _ready() -> void:
	pos_dif = $PathFollow3D.global_position
	last_pos = $PathFollow3D.global_position

func _physics_process(delta: float) -> void:
	if $PathFollow3D.progress_ratio > 0 and started:
		#if $PathFollow3D.progress < 500 and $PathFollow3D.progress > 334:
		#$AnimationPlayer.play("route_p1")
		#	speed = move_toward(speed, max_speed, acc * delta)
		#$PathFollow3D.progress_ratio -= speed
		#else:
		#	speed = move_toward(speed, 0, acc * delta)
		$PathFollow3D.progress -= speed
		pos_dif =  $PathFollow3D.global_position - last_pos
		last_pos =  $PathFollow3D.global_position

func start():
	started = true
	#speed = move_toward(speed, max_speed)
	
