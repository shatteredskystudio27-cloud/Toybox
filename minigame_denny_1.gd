extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar
@onready var label: Label = $ProgressBar/Label
var rng = RandomNumberGenerator
var stupid1 = false
var stupid2 = false
var stupid3 = false
var stupid4 = false
var stupid5 = false
var stupid6 = false
var stupid7 = false
var stupid8 = false
var stupid9 = false




func _ready():
	rng = RandomNumberGenerator.new()
	
	
func _process(delta: float) -> void:
	if State.minigame_1 == true:
		$Timer2.start()
		State.minigame_1 = false
		State.score = 0
		var stupid1 = false
		var stupid2 = false
		var stupid3 = false
		var stupid4 = false
		var stupid5 = false
		var stupid6 = false
		var stupid7 = false
		var stupid8 = false
		var stupid9 = false
	progress_bar.value = - $Timer.time_left + progress_bar.max_value
	if State.score == 1:
		label.text = "1" 
	if State.score == 2:
		label.text = "2" 
	if State.score == 3:
		label.text = "3" 

func _on_timer_2_timeout() -> void:
	$CharacterBody2D.position.x = 160
	$CharacterBody2D.position.y = 90
	random_position($Node2D)
	random_position($Node2D2)
	random_position($Node2D3)
	$AnimationPlayer.play("Fade_in")
	await $AnimationPlayer.animation_finished
	$ColorRect2/ArrowkeysWithspacebar.hide()
	$Timer.start()
	progress_bar.max_value = $Timer.time_left
	$ProgressBar.show()


func _on_timer_timeout() -> void:
	if State.score == 3:
		$ColorRect2/Label.text = "Game won :)"
		State.game_won = true
	else:
		$ColorRect2/Label.text = "Game failed :("
		State.game_won = false
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(.5).timeout



func random_position(body):
	rng.randomize()
	var num = randi_range(0, 8)
	if num == 0:
		if stupid1 == true:
			random_position(body)
		else:
			body.position = $Marker2D.position
			stupid1 = true
	if num == 1:
		if stupid2 == true:
			random_position(body)
		else:
			body.position = $Marker2D2.position
			stupid2 = true
	if num == 2:
		if stupid3 == true:
			random_position(body)
		else:
			body.position = $Marker2D3.position
			stupid3 = true
	if num == 3:
		if stupid4 == true:
			random_position(body)
		else:
			body.position = $Marker2D4.position
			stupid4 = true
	if num == 4:
		if stupid5 == true:
			random_position(body)
		else:
			body.position = $Marker2D5.position
			stupid5 = true
	if num == 5:
		if stupid6 == true:
			random_position(body)
		else:
			body.position = $Marker2D6.position
			stupid6 = true
	if num == 6:
		if stupid7 == true:
			random_position(body)
		else:
			body.position = $Marker2D7.position
			stupid7 = true
	if num == 7:
		if stupid8 == true:
			random_position(body)
		else:
			body.position = $Marker2D8.position
			stupid8 = true
	if num == 8:
		if stupid9 == true:
			random_position(body)
		else:
			body.position = $Marker2D9.position
			stupid9 = true
