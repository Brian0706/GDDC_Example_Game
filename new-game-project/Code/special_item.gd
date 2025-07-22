extends CharacterBody2D

signal powerup_collected

const SPEED = 300.0
var direction = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_wall():
		direction *= -1
	velocity.x = direction * SPEED

	move_and_slide()

func consume():
	emit_signal("powerup_collected")
	call_deferred("queue_free")
	print("Special item picked up!")
