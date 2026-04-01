extends Node2D

var rng = RandomNumberGenerator
@onready var progress_bar: ProgressBar = $ProgressBar
var win = false
var dir_1 = 0
var dir_2 = 0
var dir_3 = 0
var dir_4 = 0
var dir_5 = 0
var tracker = 0
var dir_1_u = 0
var dir_2_u = 0
var dir_3_u = 0
var dir_4_u = 0
var dir_5_u = 0
var tracker_you = 0
var thing = false




func _ready():
	rng = RandomNumberGenerator.new()

func _process(delta: float) -> void:
	if State.minigame_3 == true:
		State.minigame_3 = false
		win = false
		$AnimationPlayer.play("RESET")
		$ColorRect2/SpacebarWithoutarrowkeys.show()
		$ColorRect2/Label.text = "REMEBER!"
		$Timer2.start()
		random_direction($Node2D/arrow1)
		random_direction($Node2D/arrow2)
		random_direction($Node2D/arrow3)
		random_direction($Node2D/arrow4)
		random_direction($Node2D/arrow5)
	progress_bar.value = - $Timer.time_left + progress_bar.max_value
	if dir_1 == dir_1_u and dir_2 == dir_2_u and dir_3 == dir_3_u and dir_4 == dir_4_u and dir_5 == dir_5_u:
		win = true
	
	
func _on_timer_2_timeout() -> void:
	$AnimationPlayer.play("Fade_in")
	await $AnimationPlayer.animation_finished
	$ColorRect2/SpacebarWithoutarrowkeys.hide()
	$Timer.start()
	$Timer3.start()
	progress_bar.max_value = $Timer.time_left
	$ProgressBar.show()
	
	
func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("down")
		detect_ballsack("down", 1)
	elif Input.is_action_just_pressed("ui_up"):
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("up")
		detect_ballsack("up", 2)
	elif Input.is_action_just_pressed("ui_left"):
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("left")
		detect_ballsack("left", 3)
	elif Input.is_action_just_pressed("ui_right"):
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("right")
		detect_ballsack("right", 4)
	else:
		$AnimatedSprite2D.hide()

func _on_timer_timeout() -> void:
	if win == true:
		$ColorRect2/Label.text = "Game won :)"
		State.game_won = true
	if win == false:
		$ColorRect2/Label.text = "Game failed :("
		State.game_won = false
	$AnimationPlayer.play("fade_out")
	print(dir_1_u)
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(.5).timeout


func random_direction(sprite):
	rng.randomize()
	var num = randi_range(1, 4)
	if num == 1:
		sprite.play("down")
	if num == 2:
		sprite.play("up")
	if num == 4:
		sprite.play("right")
	if num == 3:
		sprite.play("left")
	tracker += 1
	if tracker == 1:
		dir_1 = num
	if tracker == 2:
		dir_2 = num
	if tracker == 3:
		dir_3 = num
	if tracker == 4:
		dir_4 = num
	if tracker == 5:
		dir_5 = num


func _on_timer_3_timeout() -> void:
	$AnimationPlayer.play("new_animation")
	await $AnimationPlayer.animation_finished
	$DennyEyesmouthclosed.hide()
	$Node2D/arrow1.hide()
	$Node2D/arrow2.hide()
	$Node2D/arrow3.hide()
	$Node2D/arrow4.hide()
	$Node2D/arrow5.hide()
	$Node2D.modulate = Color(1.0, 1.0, 1.0, 1.0)
	thing = true
	
	
func detect_ballsack(ballsack, cock):
	if thing == true:
		print("cock n balls")
		tracker_you += 1
		if tracker_you == 1:
			$Node2D/arrow1.play(ballsack)
			$Node2D/arrow1.show()
			dir_1_u = cock
		if tracker_you == 2:
			$Node2D/arrow2.play(ballsack)
			$Node2D/arrow2.show()
			dir_2_u = cock
		if tracker_you == 3:
			$Node2D/arrow3.play(ballsack)
			$Node2D/arrow3.show()
			dir_3_u = cock
		if tracker_you == 4:
			$Node2D/arrow4.play(ballsack)
			$Node2D/arrow4.show()
			dir_4_u = cock
		if tracker_you == 5:
			$Node2D/arrow5.play(ballsack)
			$Node2D/arrow5.show()
			dir_5_u = cock
