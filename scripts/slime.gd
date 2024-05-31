extends Node2D

const speed = 60

var direction = 1

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D

func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	#position.x += direction * speed * delta


func _on_killzone_body_entered(body):
	if !body.right_attack.disabled or !body.left_attack.disabled:
		GlobalMusic.play_hit_sound()
		queue_free()
