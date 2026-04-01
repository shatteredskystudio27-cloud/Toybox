extends Control

func _ready() -> void:
	$AnimationPlayer.play("fade_in")


func _on_button_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	State.target -= 3
	if State.target < 0:
		State.target = 0
	await $AnimationPlayer.animation_finished
	self.queue_free()
