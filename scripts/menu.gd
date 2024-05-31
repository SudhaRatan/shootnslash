extends CanvasLayer

func _ready():
	Global.load_game()
	if Global.coin_count == null:
		Global.coin = 0
		Global.save_game()
	$TotalCoins.text = str(Global.coin_count)

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
