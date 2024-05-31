extends Node

@onready var score_label = $ScoreLabel
@onready var hud = $Hud

func add_point():
	Global.current_coin_count += 1
	score_label.text = "You collected " + str(Global.current_coin_count) + " coins."
	hud.get_node("Panel/count").text = str(Global.current_coin_count)
