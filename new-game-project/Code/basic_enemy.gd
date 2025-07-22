extends CharacterBody2D

@onready var animations: AnimatedSprite2D= $AnimatedSprite2D

const SPEED = 150.0
var direction = -1

func killed():
	call_deferred("queue_free")
	animations.play("death_animation")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = direction * SPEED
	
	# ANIMATION SECTION
	if (direction > 0):
		animations.play("walk_right_animation")
	else:
		animations.play("walk_left_animation")
	if is_on_wall():
		direction *= -1
		if (direction > 0):
			animations.play("walk_right_animation")
		else:
			animations.play("walk_left_animation")
	move_and_slide()
