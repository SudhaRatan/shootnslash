extends Node

var coin_count: int = 0
var current_coin_count: int = 0

var level_info: Dictionary = {
	"level1": true,
	"level2": false
}

func save_game():
	var save_data = {
		"coin_count": coin_count
	}
	var save_file = FileAccess.open("user://save_game.dat",FileAccess.WRITE)
	save_file.store_var(save_data)
	save_file.close()

func load_game():
	var save_file = FileAccess.open("user://save_game.dat", FileAccess.READ)
	if save_file:
		var save_data = save_file.get_var()
		coin_count = save_data.get("coin_count", 0)
		save_file.close()

