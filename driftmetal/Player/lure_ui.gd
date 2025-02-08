extends Control

var transparent_amount = 0.35

@onready var hook = $HBoxContainer/hook/hook
@onready var worm = $HBoxContainer/worm/worm
@onready var bread = $HBoxContainer/bread/bread
@onready var sardines = $HBoxContainer/sardines/sardines

func _process(delta: float) -> void:
	$HBoxContainer/worm/stock.text = str(Global.worms)
	$HBoxContainer/bread/stock.text = str(Global.bread)
	$HBoxContainer/sardines/stock.text = str(Global.sardines)
	
	
	if Global.selected_bait == 0:
		hook.modulate = Color(1, 1, 1, 1)
	else:
		hook.modulate = Color(1, 1, 1, transparent_amount)
	if Global.selected_bait == 1:
		worm.modulate = Color(1, 1, 1, 1)
	else:
		worm.modulate = Color(1, 1, 1, transparent_amount)
	if Global.selected_bait == 2:
		bread.modulate = Color(1, 1, 1, 1)
	else:
		bread.modulate = Color(1, 1, 1, transparent_amount)
	if Global.selected_bait == 3:
		sardines.modulate = Color(1, 1, 1, 1)
	else:
		sardines.modulate = Color(1, 1, 1, transparent_amount)
	
	if Input.is_action_just_pressed("bait_left"):
		if Global.selected_bait != 0:
			Global.selected_bait -= 1
		else:
			Global.selected_bait = Global.max_select
	if Input.is_action_just_pressed("bait_right"):
		if Global.selected_bait != Global.max_select:
			Global.selected_bait += 1
		else:
			Global.selected_bait = 0
