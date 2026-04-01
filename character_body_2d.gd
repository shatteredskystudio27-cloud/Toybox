extends CharacterBody2D

@export var SPEED = 100
@export var jump_velocity = -450
@export var gravity_multiplier = 2.0
@export var currentlevel:Node2D

var current_jumps = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	apply_gravity(delta)
	haddle_jump()
	handle_movement()
	anim_play()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * gravity_multiplier * delta

func haddle_jump():
	if Input.is_action_just_pressed("ui_accept"):
		$AnimatedSprite2D.play("jump")
		if is_on_floor():
			$AnimatedSprite2D.play("jump")
			velocity.y = jump_velocity
			current_jumps += 1

func handle_movement():
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()


func anim_play():
	if is_on_floor() == false:
		$AnimatedSprite2D.play("jump")
	elif Input.is_action_pressed("ui_left") and is_on_floor():
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("ui_right") and is_on_floor():
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.play("idle")


func _on_area_2d_body_entered(body):
	body.queue_free()
	print("nutsack")
	State.score += 1
	$AudioStreamPlayer2D.play()
