extends Node

var sound: AudioStream

func play_hit_sound():
	sound = load("res://assets/sounds/hurt.wav")
	play_sound()
func play_sound():
	if sound:
		# Create an AudioStreamPlayer instance
		var audio_player = AudioStreamPlayer.new()
		audio_player.stream = sound
		
		# Add the AudioStreamPlayer instance to the scene tree temporarily
		add_child(audio_player)
		
		# Connect to the finished signal to remove the player after it is done playing
		
		# Play the sound
		audio_player.play()
