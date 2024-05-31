extends Area2D

var speed = 600
var velocity = Vector2.ZERO

func _ready():
	if Input.is_action_pressed("move_left"):
		velocity.x = -1
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	velocity = velocity * speed
	if velocity.x != 0:
		$Sprite2D.flip_h = velocity.x < 0

func _process(delta):
	position += velocity * delta

func _on_body_entered(body):
	if body.name == "Slime":
		GlobalMusic.play_hit_sound()
		body.queue_free()
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
