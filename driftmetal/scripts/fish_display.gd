extends Node3D

var selected_fish
var fishes: Array

@onready var fish_1 = $"fish/fish 1"
@onready var fish_2 = $"fish/fish 2"
@onready var fish_3 = $"fish/fish 3"

func _ready() -> void:
	fishes = [fish_1, fish_2, fish_3]
	fish_vis("fish_3")
	#pass # Replace with function body.


func _process(delta: float) -> void:
	$fish.rotation.y += 1 * delta

func fish_vis(fish: String):
	for i in fishes:
		if i == get(fish):
			i.visible = true
		else:
			i.visible = false
