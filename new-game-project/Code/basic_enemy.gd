extends CharacterBody2D

@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var rayCast: RayCast2D = $WallCheck

const SPEED = 150.0
var direction = 1

func killed():
	call_deferred("queue_free")
	animations.play("death_animation")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = direction * SPEED
	if rayCast.is_colliding():
		direction *= -1
		#By negating the scale we can flip the entire scene, include the raycast, not just the animation
		self.scale.x *= -1

	# ANIMATION SECTION
	animations.play("walk")
	move_and_slide()
