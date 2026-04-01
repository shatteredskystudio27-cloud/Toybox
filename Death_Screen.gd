extends Control




func _on_retry_pressed() -> void:
	$AudioStreamPlayer2D.play()
	await (get_tree().create_timer(.1).timeout)
	get_tree().change_scene_to_file("%s" % State.scene)




func _on_menu_pressed() -> void:
	$AudioStreamPlayer2D.play()
	await (get_tree().create_timer(.1).timeout)
	get_tree().change_scene_to_file("res://MainMenu.tscn")
