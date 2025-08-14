extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -250.0
const INVULNERABILITY = 0.5
var timeSinceLastHit = 1
var direction = 1

@onready var lifeSpanTimer: Timer = $ObjectLifeSpan

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * Global.fallingModifier * delta
	else:
		velocity.y = JUMP_VELOCITY
	velocity.x = SPEED * direction
	move_and_slide()


func _on_hit_detection_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Enemy")):
		body.killed(true)
		self.queue_free()

func _on_sound_timeout() -> void:
	self.queue_free()
