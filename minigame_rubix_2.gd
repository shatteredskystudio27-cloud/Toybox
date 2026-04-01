extends Node2D

var rng = RandomNumberGenerator
@onready var progress_bar: ProgressBar = $ProgressBar
var shimmy = false
var win = false


func _ready():
	rng = RandomNumberGenerator.new()
	$AudioStreamPlayer2D3.volume_db = -80
	$AudioStreamPlayer2D.volume_db = -80

func _process(delta: float) -> void:
	if State.minigame_2 == true:
		$Icon.play('default')
		$AudioStreamPlayer2D3.volume_db = 5.647
		$AudioStreamPlayer2D.volume_db = 13
		$Icon.show()
		$Rubixcheckmark.hide()
		$Rubixxmark.hide()
		$Rubixsminigameblank.hide()
		$Timer2.start()
		State.minigame_2 = false
	progress_bar.value = - $Timer.time_left + progress_bar.max_value
	if Input.is_action_just_pressed("react") and shimmy == false:
		$AudioStreamPlayer2D3.play()
		win = false
		$Timer3.stop()
		$Rubixxmark.show()
	
func _on_timer_2_timeout() -> void:
	rng.randomize()
	var num = randi_range(3, 7)
	$AnimationPlayer.play("Fade_in")
	$Timer3.wait_time = num
	await $AnimationPlayer.animation_finished
	$ColorRect2/SpacebarWithoutarrowkeys.hide()
	$Timer.start()
	$Timer3.start()
	progress_bar.max_value = $Timer.time_left
	$ProgressBar.show()
	

func _input(event):
	if Input.is_action_just_pressed("react") and shimmy == true:
		win = true
		$Rubixcheckmark.show()
		$AudioStreamPlayer2D.play()

func _on_timer_3_timeout() -> void:
	$Timer4.start()
	$ColorRect. modulate = Color(0.02, 0.048, 0.02, 1.0)
	shimmy = true
	$Rubixsminigameblank.show()
	
func _on_timer_4_timeout() -> void:
	$ColorRect. modulate = Color(1.0, 1.0, 1.0, 1.0)
	shimmy = false
	
	if win == false:
		$AudioStreamPlayer2D3.play()
		$Rubixsminigameblank.hide()
		$Icon.show()
		$Rubixxmark.show()



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
