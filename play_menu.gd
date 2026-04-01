extends Control




func _on_campaign_pressed() -> void:
	$AudioStreamPlayer2D.play()
	await (get_tree().create_timer(.1).timeout)
	get_tree().change_scene_to_file("res://intro.tscn")
