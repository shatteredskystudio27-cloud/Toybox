extends Node2D

var IDFK_MAN = 3
var IDFK_DUDE = 3


@onready var progress_bar: ProgressBar = $ProgressBar




func _process(delta: float) -> void:
	if State.minigame_1 == true:
		$Timer2.start()
		State.minigame_1 = false
	progress_bar.value = - $Timer.time_left + progress_bar.max_value
	if IDFK_MAN == 2:
		$Rubixsminigameblank/ColorRect1.hide()
	if IDFK_MAN == 1:
		$Rubixsminigameblank/ColorRect2.hide()
	if IDFK_MAN == 0:
		$Rubixsminigameblank/ColorRect3.hide()
	if IDFK_DUDE == 2:
		$Rubixsminigameblank2/ColorRect1.hide()
	if IDFK_DUDE == 1:
		$Rubixsminigameblank2/ColorRect2.hide()
	if IDFK_DUDE == 0:
		$Rubixsminigameblank2/ColorRect3.hide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	$AudioStreamPlayer2D.play()
	body.queue_free()
	IDFK_MAN -= 1

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	$AudioStreamPlayer2D.play()
	body.queue_free()
	IDFK_DUDE -= 1


func _on_timer_2_timeout() -> void:
	$AnimationPlayer.play("Fade_in")
	await $AnimationPlayer.animation_finished
	$Timer.start()
	$ColorRect2/Mouseicon.hide()
	progress_bar.max_value = $Timer.time_left
	$ProgressBar.show()


func _on_timer_timeout() -> void:
	if IDFK_DUDE == 0 and IDFK_DUDE == 0:
		$ColorRect2/Label.text = "Game won :)"
		State.game_won = true
	if IDFK_DUDE > 0 and IDFK_DUDE > 0:
		$ColorRect2/Label.text = "Game failed :("
		State.game_won = false
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(.5).timeout
