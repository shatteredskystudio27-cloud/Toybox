extends Node2D


var rng = RandomNumberGenerator
@onready var progress_bar: ProgressBar = $ProgressBar
var green = Color(0.118, 0.804, 0.0, 1.0)
var white = Color(1.0, 1.0, 1.0, 1.0)
var blue = Color(0.0, 0.271, 1.0, 1.0)
var red = Color(1.0, 0.0, 0.0, 1.0)
var square1 = false
var color1 = 1
var square2 = false
var color2 = 1
var square3 = false
var color3 = 1
var square4 = false
var color4 = 1
var square5 = false
var color5 = 1
var square6 = false
var color6 = 1
var square7 = false
var color7 = 1
var square8 = false
var color8 = 1
var square9 = false
var color9 = 1
var num1 = 0	
var num2 = 0
var num3 = 0
var num4 = 0
var num5 = 0
var num6 = 0
var num7 = 0
var num8 = 0
var num9 = 0
var win = false
var tracker = 0

func _ready():
	rng = RandomNumberGenerator.new()
	display_color()

func _process(delta: float) -> void:
	if State.minigame_3 == true:
		$Timer2.start()
		State.minigame_3 = false
	progress_bar.value = - $Timer.time_left + progress_bar.max_value
	if color1 == num1 and color2 == num2 and color3 == num3 and color4 == num4 and color5 == num5 and color6 == num6 and color7 == num7 and color8 == num8 and color9 == num9:
		win = true


func _on_timer_2_timeout() -> void:
	$AnimationPlayer.play("Fade_in")
	await $AnimationPlayer.animation_finished
	$ColorRect2/ArrowkeysWithspacebar.hide()
	$Timer.start()
	progress_bar.max_value = $Timer.time_left
	$ProgressBar.show()


func change_color(body, color):
	body.modulate = Color(color)

func random_color(body):
	rng.randomize()
	var num = randi_range(0, 3)
	if num == 0:
		change_color(body, white)
	if num == 1:
		change_color(body, blue)
	if num == 2:
		change_color(body, green) #AMERICA
	if num == 3:
		change_color(body, red)
	num += 1
	if num > 3:
		num = 0
	tracker += 1
	if tracker == 1:
		num1 = num
	if tracker == 2:
		num2 = num
	if tracker == 3:
		num3 = num
	if tracker == 4:
		num4 = num
	if tracker == 5:
		num5 = num
	if tracker == 6:
		num6 = num
	if tracker == 7:
		num7 = num
	if tracker == 8:
		num8 = num
	if tracker == 9:
		num9 = num
	
	
func display_color():
	random_color($Node2D/RubixCubeMinigame1Small)
	random_color($Node2D/RubixCubeMinigame1Small2)
	random_color($Node2D/RubixCubeMinigame1Small3)
	random_color($Node2D/RubixCubeMinigame1Small4)
	random_color($Node2D/RubixCubeMinigame1Small5)
	random_color($Node2D/RubixCubeMinigame1Small6)
	random_color($Node2D/RubixCubeMinigame1Small7)
	random_color($Node2D/RubixCubeMinigame1Small8)
	random_color($Node2D/RubixCubeMinigame1Small9)
	print(num1)

	
func _on_timer_timeout() -> void:
	if win == true:
		$ColorRect2/Label.text = "Game won :)"
		State.game_won = true
	if win == false:
		$ColorRect2/Label.text = "Game failed :("
		State.game_won = false
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(.5).timeout
	
func ran_out_of_names(bull, shit):
	if shit == 0:
		change_color(bull, red)
	elif shit == 1:
		change_color(bull, white)
	elif shit == 2:
		change_color(bull, blue) #AMERICA
	elif shit == 3:
		change_color(bull, green)


func _on_area_2d_body_entered(body: Node2D) -> void:
	square1 = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	square1 = false

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	square2 = true

func _on_area_2d_2_body_exited(body: Node2D) -> void:
	square2 = false

func _on_area_2d_3_body_entered(body: Node2D) -> void:
	square3 = true

func _on_area_2d_3_body_exited(body: Node2D) -> void:
	square3 = false

func _on_area_2d_4_body_entered(body: Node2D) -> void:
	square4 = true

func _on_area_2d_4_body_exited(body: Node2D) -> void:
	square4 = false

func _on_area_2d_5_body_entered(body: Node2D) -> void:
	square5 = true

func _on_area_2d_5_body_exited(body: Node2D) -> void:
	square5 = false

func _on_area_2d_6_body_entered(body: Node2D) -> void:
	square6 = true

func _on_area_2d_6_body_exited(body: Node2D) -> void:
	square6 = false

func _on_area_2d_7_body_entered(body: Node2D) -> void:
	square7 = true

func _on_area_2d_7_body_exited(body: Node2D) -> void:
	square7 = false

func _on_area_2d_8_body_entered(body: Node2D) -> void:
	square8 = true

func _on_area_2d_8_body_exited(body: Node2D) -> void:
	square8 = false

func _on_area_2d_9_body_entered(body: Node2D) -> void:
	square9 = true

func _on_area_2d_9_body_exited(body: Node2D) -> void:
	square9 = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("react"):
		if square1 == true:
			color1 += 1
			if color1 > 3:
				color1 = 0
			ran_out_of_names($Node2D2/RubixCubeMinigame1Small, color1)
		if square2 == true:
			color2 += 1
			if color2 > 3:
				color2 = 0
			ran_out_of_names($Node2D2/RubixCubeMinigame1Small2, color2)
			
		if square3 == true:
			color3 += 1
			if color3 > 3:
				color3 = 0
			ran_out_of_names($Node2D2/RubixCubeMinigame1Small3, color3)
		if square4 == true:
			color4 += 1
			if color4 > 3:
				color4 = 0
			ran_out_of_names($Node2D2/RubixCubeMinigame1Small4, color4)
		if square5 == true:
			color5 += 1
			if color5 > 3:
				color5 = 0
			ran_out_of_names($Node2D2/RubixCubeMinigame1Small5, color5)
		if square6 == true:
			color6 += 1
			if color6 > 3:
				color6 = 0
			ran_out_of_names($Node2D2/RubixCubeMinigame1Small6, color6)
			
		if square7 == true:
			color7 += 1
			if color7 > 3:
				color7 = 0
			ran_out_of_names($Node2D2/RubixCubeMinigame1Small7, color7)
		if square8 == true:
			color8 += 1
			if color8 > 3:
				color8 = 0
			ran_out_of_names($Node2D2/RubixCubeMinigame1Small8, color8)
		if square9 == true:
			color9 += 1
			if color9 > 3:
				color9 = 0
			ran_out_of_names($Node2D2/RubixCubeMinigame1Small9, color9)
