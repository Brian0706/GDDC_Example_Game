extends CharacterBody2D

signal player_damage_taken
const projectile = preload("res://Scenes/Powers/fireball.tscn")

#Sounds
@onready var walkingSound: AudioStreamPlayer = $Sounds/Walk
@onready var jumpingSound: AudioStreamPlayer = $Sounds/Jump
@onready var takeDamageSound: AudioStreamPlayer = $Sounds/Hurt
@onready var pickUpSound: AudioStreamPlayer = $Sounds/PickItem
@onready var attackSound: AudioStreamPlayer = $Sounds/Attack
@onready var jumpAttackSound: AudioStreamPlayer = $Sounds/Stomp

# DIRECTION CONSTANTS
const SPEED = 350.0
const JUMP_VELOCITY = -500.0
const INVULNERABILITY = 0.5
var timeSinceLastHit = 1
# I know this looks stupid but I'm saving the formula in case we want the player to scale infinitely.
# Just learned the concept of computeed properties
# Values that are computed every time it's accessed instead of being set once at runtime.
var powerUpModifier:
	get:
		return (1 + (2 - 1) / 4.0) if Global.hasPowerUp else (1 + (1 - 1) / 4.0)

@onready var animations: AnimatedSprite2D = $AnimatedSprite2D

func _connect_item_to_signals() -> void:
	self.player_damage_taken.connect(Global._on_player_damage_taken)

func _ready() -> void:
	_update_size()
	_connect_item_to_signals()

func _physics_process(delta: float) -> void:
	# PHYSICS
	timeSinceLastHit += delta
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * Global.fallingModifier * delta * 1.2
	elif velocity.x != 0:
		walkingSound.play()
	else:
		walkingSound.stop()
		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jumpingSound.play()
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED * powerUpModifier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#Projectile attack
	if Input.is_action_just_pressed("projectile_attack") and Global.hasProjectile:
		var attack = projectile.instantiate()
		attackSound.play()
		#Needed to prevent projectiles from moving with player
		get_parent().add_child(attack)
		attack.position.x = self.position.x
		attack.position.y = self.position.y
		if !animations.flip_h == true:
			attack.direction = -1
	
	move_and_slide()
	_update_animation()

func _update_animation() -> void:
	if is_on_floor():
		if velocity.x == 0:
			animations.play("widle")
		else:
			animations.play("wwalk")
	else:
		if (velocity.y > 0):
			animations.play("wjumpdown")
		else:
			animations.play("wjumpup")
	#Nothing for when velocity.x == 0 because they should maintain the direction they are facing
	if velocity.x > 0:
		animations.flip_h = true
	elif velocity.x < 0:
		animations.flip_h = false

func _update_size() -> void:
	self.scale.x = powerUpModifier
	self.scale.y = powerUpModifier

func _on_powerup_collected() -> void:
	_update_size()
	Global.hasPowerUp = true
	$"../CanvasLayer/HUD".updateLivesLabel()
	pass

func takeDamage():
	if (timeSinceLastHit > INVULNERABILITY):
		$"../CanvasLayer/HUD".updateLivesLabel()
		emit_signal("player_damage_taken")
		_update_size()
		timeSinceLastHit = 0
		print("Damage taken!")

func changeCostume(frames: Resource):
	animations.set_sprite_frames(frames)

func _on_hit_detection_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Items")):
		pickUpSound.play()
		body.consume()
		_update_size()
	elif (body.is_in_group("Enemy")) or (body.is_in_group("LethalObjects")) or (body.is_in_group("Projectile")):
		takeDamageSound.play()
		takeDamage()
	

func _on_attack_detection_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Items")):
		body.consume()
	elif (body.is_in_group("Enemy")):
		velocity.y = JUMP_VELOCITY / 2
		jumpAttackSound.play()
		body.killed()
		print("Dealt damage!")
