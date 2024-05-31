extends Area2D

@onready var timer = $Timer
@onready var death_sound = $DeathSound

@export var type: String

func _on_body_entered(body):
	if type == "enemy":
		if body.name == "Player" and body.attack_timer .is_stopped():
			Engine.time_scale = 0.5
			body.get_node("DeadTimer").start()
			body.get_node("AnimatedSprite2D").play("dead")
			Global.current_coin_count = 0
	else:
		Engine.time_scale = 0.5
		body.get_node("CollisionShape2D").queue_free()
		Global.current_coin_count = 0
	timer.start()
	death_sound.play()
	

func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
