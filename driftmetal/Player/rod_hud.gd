extends Control



func _ready() -> void:
	pass


func _process(delta: float) -> void:
	$cast_strength.value = $"../..".cast_strength
