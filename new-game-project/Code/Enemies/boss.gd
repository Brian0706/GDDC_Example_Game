extends Enemy

@onready var jumpCooldown: Timer = $JumpAttackTimer
const JUMP_VELOCITY = -300

func jumping_attack(delta: float):
	direction = int(sign(Global.player.position.x - self.position.x))
	velocity.y = JUMP_VELOCITY
	velocity.x = SPEED * direction
	self.scale.x = direction * -1
	jumpCooldown.wait_time = randf_range(3, 4)
	jumpCooldown.start()
	curState = 0
	print(velocity)
	move_and_slide()

func walking(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = direction * SPEED
	if wallCheck.is_colliding():
		direction *= -1
		#By negating the scale we can flip the entire scene, include the raycast, not just the animation
		self.scale.x *= -1
	
	# ANIMATION SECTION
	animations.play("walk")
	move_and_slide()

func _on_jump_attack_timer_timeout() -> void:
	curState = 2

func _ready() -> void:
	super._ready()
	states.append(Callable(self, "jumping_attack"))
