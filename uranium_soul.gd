extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var nut = true
var dead = true

func _ready() -> void:
	$GearSoul.show()
	$GearSoul.play("idle")


func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and nut == true:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var direction2 := Input.get_axis("ui_up", "ui_down")
	if direction2 and nut == true:
		velocity.y = direction2 * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if dead == true:
		dead = false
		nut = false
		$GearSoul.play("death")
		State.alive = false
		await $GearSoul.animation_finished
		$GearSoul.hide()
