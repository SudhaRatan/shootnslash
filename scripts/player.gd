extends CharacterBody2D


var SPEED = 130.0
const JUMP_VELOCITY = -300.0
@export var bullet_scene: PackedScene
@onready var animated_sprite = $AnimatedSprite2D
@onready var attack_timer = $AttackTimer
@onready var dead_timer = $DeadTimer
@onready var right_attack = $RightAttack
@onready var left_attack = $LeftAttack
@onready var shoot_timer = $ShootTimer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if attack_timer.is_stopped() and shoot_timer.is_stopped():
		SPEED = 130.0
	else:
		SPEED = 20
	# Handle jump.
	if !dead_timer.is_stopped():
		return
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$JumpSound.play()

	# Get the input direction -1 0 1
	var direction = Input.get_axis("move_left", "move_right")
	
	#Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	#Play animations
	if Input.is_action_pressed("attack"):
		attack_timer.start()
		animated_sprite.play("attack")
	elif Input.is_action_pressed("shoot"):
		shoot_timer.start()
		animated_sprite.play("shoot")
		
	if attack_timer.is_stopped() and shoot_timer.is_stopped():
		right_attack.disabled = true
		left_attack.disabled = true
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
	else:
		if velocity.x > 0 or !animated_sprite.flip_h:
			right_attack.disabled = false
			left_attack.disabled = true
		elif velocity.x < 0 or animated_sprite.flip_h:
			right_attack.disabled = true
			left_attack.disabled = false
	
	#Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_shoot_timer_timeout():
	var bullet = bullet_scene.instantiate()
	bullet.position.y = -15
	if !animated_sprite.flip_h:
		bullet.velocity.x = 1
		bullet.position.x = 10
	else:
		bullet.velocity.x = -1
		bullet.position.x = -10
	add_child(bullet)
