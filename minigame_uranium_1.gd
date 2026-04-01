extends Node2D

@onready var label: Label = $ProgressBar/Label
const CROSSHAIR = preload("uid://bbcgqobop7e7c")
@onready var progress_bar: ProgressBar = $ProgressBar
var win = false

@export var height: = 180
@export var width: = 320
var target = preload("res://target.tscn")
var bomb = preload("res://bomb.tscn")
var tracker = 0
var shimmy = false

func _process(delta: float) -> void:
	if State.minigame_1 == true:
		$Timer2.start()
		State.minigame_1 = false
	progress_bar.value = - $Timer.time_left + progress_bar.max_value
	label.text = str(State.target)
	if State.target == 7:
		win = true
	if Input.is_action_just_pressed("LMB a.k.a. lick my balls") and shimmy == true:
		$AnimationPlayer2.play("gun_shot")

func _on_timer_2_timeout() -> void:
	State.target = 0
	win = false
	$AnimationPlayer.play("Fade_in")
	await $AnimationPlayer.animation_finished
	$Timer.start()
	Input.set_custom_mouse_cursor(CROSSHAIR)
	$ColorRect2/Mouseicon.hide()
	progress_bar.max_value = $Timer.time_left
	$ProgressBar.show()
	$Timer3.start()
	shimmy = true

func _on_timer_timeout() -> void:
	shimmy = false
	Input.set_custom_mouse_cursor(null)
	if win == true:
		$ColorRect2/Label.text = "Game won :)"
		State.game_won = true
	if win == false:
		$ColorRect2/Label.text = "Game failed :("
		State.game_won = false
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(.5).timeout


func nutsack():
	var nheight = randi_range(1, height)
	var nwidth = randi_range(0, width)
	var targetScene = target.instantiate()
	targetScene.position = Vector2(nwidth, nheight)
	add_child(targetScene)
	
func ballsack():
	var nheight = randi_range(1, height)
	var nwidth = randi_range(0, width)
	var bombScene = bomb.instantiate()
	bombScene.position = Vector2(nwidth, nheight)
	add_child(bombScene)
	


func _on_timer_3_timeout() -> void:
	if tracker < 3:
		nutsack()
		tracker += 1
	if tracker == 3:
		tracker = 0
	ballsack()
