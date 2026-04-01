extends Node2D

const speed = 100

func _process(delta: float) -> void:
	position += transform.x * speed * delta
	


func _on_killtimer_timeout() -> void:
	self.queue_free()
