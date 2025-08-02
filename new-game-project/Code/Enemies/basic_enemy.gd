class_name Enemy extends CharacterBody2D

@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var wallCheck: RayCast2D = $WallCheck
@onready var pitCheck: RayCast2D = $PitCheck

const SPEED = 150.0
var direction = 1
var states = []
var curState = 0

func killed():
	animations.play("death_animation")
	call_deferred("queue_free")

func walking(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = direction * SPEED
	if wallCheck.is_colliding() or not pitCheck.is_colliding():
		direction *= -1
		#By negating the scale we can flip the entire scene, include the raycast, not just the animation
		self.scale.x *= -1

	# ANIMATION SECTION
	animations.play("walk")
	move_and_slide()


func _ready() -> void:
	states.append(Callable(self, "walking"))
	states.append(Callable(self, "killed"))

func _physics_process(delta: float) -> void:
	states[curState].call(delta)