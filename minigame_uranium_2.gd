extends Node2D


const bullet_scene = preload("res://bullet_spawner.tscn")
@onready var progress_bar: ProgressBar = $ProgressBar
var win = false

func _process(delta: float) -> void:
	if State.minigame_2 == true:
		$Timer2.start()
		var spawner = bullet_scene.instantiate()
		$Marker2D.add_child(spawner)
		State.minigame_2 = false
		State.alive = true
	if State.alive == true:
		win = true
	if State.alive == false:
		win = false
	progress_bar.value = - $Timer.time_left + progress_bar.max_value

func _on_timer_2_timeout() -> void:
	$AnimationPlayer.play("Fade_in")
	await $AnimationPlayer.animation_finished
	$ColorRect2/SpacebarWithoutarrowkeys.hide()
	$Timer.start()
	progress_bar.max_value = $Timer.time_left
	$ProgressBar.show()


func _on_timer_timeout() -> void:
	if win == true:
		$ColorRect2/Label.text = "Game won :)"
		State.game_won = true
	if win == false:
		$ColorRect2/Label.text = "Game failed :("
		State.game_won = false
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	$Marker2D/BulletSpawner.queue_free()
	await get_tree().create_timer(.5).timeout
