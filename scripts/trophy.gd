extends Area2D

func _on_body_entered(body):
	Global.coin_count += Global.current_coin_count
	Global.current_coin_count = 0
	Global.save_game()
	print(Global.coin_count, Global.current_coin_count)
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
