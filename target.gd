extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("fade_in")


func _on_button_pressed() -> void:
	$AnimationPlayer.play("fade_out")
	State.target += 1
	await $AnimationPlayer.animation_finished
	self.queue_free()
