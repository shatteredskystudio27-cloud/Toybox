extends Control


var minigame = preload("res://minigame_denny_3.tscn")

func destroy():
	if self.get_child_count() > 0:
		self.get_child(0).queue_free()



func respawn():
	var minigame_instance = minigame.instantiate()
	self.add_child(minigame_instance)
	
func _process(delta: float) -> void:
	if State.minigame_3 == true:
		await get_tree().create_timer(13.5).timeout
		destroy()
		respawn()
