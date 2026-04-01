extends CharacterBody2D


var currPos = [98, 28]


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		currPos[0] += 39
		if currPos[0] > 176:
			currPos[0] = 176
	elif event.is_action_pressed("ui_left"):
		currPos[0] -= 39
		if currPos[0] < 98:
			currPos[0] = 98
	elif event.is_action_pressed("ui_up"):
		currPos[1] -= 39
		if currPos[1] < 28:
			currPos[1] = 28
	elif event.is_action_pressed("ui_down"):
		currPos[1] += 39
		if currPos[1] > 106:
			currPos[1] = 106 

	self.position = Vector2(currPos[0], currPos[1])
