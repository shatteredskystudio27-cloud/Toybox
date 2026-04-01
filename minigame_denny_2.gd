extends Node2D

@onready var progress_bar: ProgressBar = $ProgressBar
var win = false
var john = true
var evil_john = false
var stop_repeat = false

func _process(delta: float) -> void:
	if State.minigame_2 == true:
		State.minigame_2 = false
		win = false
		$Timer2.start()
	progress_bar.value = - $Timer.time_left + progress_bar.max_value
	if $ProgressBar2.value == $ProgressBar2.max_value and stop_repeat == false:
		stop_repeat = true
		win = true
		john = false
		evil_john = false
		$DennyEyesmouthclosed.hide()
		$AudioStreamPlayer2D.play()

func _on_timer_2_timeout() -> void:
	$AnimationPlayer.play("Fade_in")
	await $AnimationPlayer.animation_finished
	$ColorRect2/SpacebarWithoutarrowkeys.hide()
	$Timer.start()
	$Timer3.start()
	progress_bar.max_value = $Timer.time_left
	$ProgressBar.show()
	evil_john = true
	
	
func _input(event):
	if Input.is_action_just_pressed("react") and evil_john == true:
		$ProgressBar2.value += 1


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


func _on_timer_3_timeout() -> void:
	if john == true:
		$ProgressBar2.value -= .5
