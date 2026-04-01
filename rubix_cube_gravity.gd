extends RigidBody2D

var dragging = false
var OF = Vector2(0,0)

func _physics_process(delta: float) -> void:
	if dragging == true:
		position = get_global_mouse_position() - OF 
		position.x -= 320
		freeze = true
	if dragging == false:
		freeze = false

func _on_button_button_down() -> void:
	dragging = true
	OF = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	dragging = false
