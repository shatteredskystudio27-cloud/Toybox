extends Control


var minigame = preload("res://minigame_denny_1.tscn")
# Called when the node enters the scene tree for the first time.
func destroy():
	if self.get_child_count() > 0:
		self.get_child(0).queue_free()



func respawn():
	var minigame_instance = minigame.instantiate()
	self.add_child(minigame_instance)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if State.minigame_1 == true:
		await get_tree().create_timer(13.5).timeout
		destroy()
		print(self.get_child_count())
		respawn()
