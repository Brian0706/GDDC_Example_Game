extends Enemy

@onready var jumpCooldown: Timer = $JumpAttackTimer
@onready var attackCooldown: Timer = $AttackCooldown
const JUMP_VELOCITY = -600
var attackAmount = 3
const projectile = preload("res://Scenes/Enemies/boss_projectile.tscn")
var projectiles_fired = 0
var isShooting = false

func killed(fireBalled = false):
	super.killed(fireBalled)
	jumpCooldown.stop()
	attackCooldown.stop()

func jumping_attack(delta: float):
	direction = int(sign(Global.player.position.x - self.position.x))
	velocity.y = JUMP_VELOCITY
	velocity.x = SPEED * direction * -1
	self.scale.x = direction * -1
	jumpCooldown.wait_time = randf_range(3, 4)
	attackCooldown.start()
	curState = 3
	isShooting = true
	move_and_slide()

func shoot_projectile(delta: float):
	walking(delta)
	var attack = projectile.instantiate()
	get_parent().add_child(attack)
	attack.position.x = self.position.x
	attack.position.y = self.position.y
	attack.direction = direction
	if attackAmount == projectiles_fired:
		jumpCooldown.start()
		attackCooldown.stop()
		isShooting = false
		attackAmount = randi_range(3, 6)
		projectiles_fired = 0
	else:
		projectiles_fired += 1
	curState = 0

func walking(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	velocity.x = direction * SPEED
	if wallCheck.is_colliding() and !isShooting:
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
	states.append(Callable(self, "shoot_projectile"))


func _on_attack_cooldown_timeout() -> void:
	curState = 3
