extends CharacterBody2D


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

func consumed():
	self.queue_free();

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		print("has been activated")
		Global.changeStage(1)
		call_deferred("consumed")
