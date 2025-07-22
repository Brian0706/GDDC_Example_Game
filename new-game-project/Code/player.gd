extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -500.0
const INVULNERABILITY = 0.5
var timeSinceLastHit = 1
# I know this looks stupid but I'm saving the formula in case we want the player to scale infinitely.
# Just learned the concept of computeed properties
# Values that are computed every time it's accessed instead of being set once at runtime.
var powerUpModifier: 
	get:
		return (1 + (2 - 1) / 2.0) if Global.hasPowerUp else (1 + (1 - 1) / 2.0)
@onready var animations: AnimatedSprite2D = $AnimatedSprite2D
 
func _ready() -> void:
	self.scale.x = powerUpModifier
	self.scale.y = powerUpModifier

func updateSize() -> void:
	self.scale.x = powerUpModifier
	self.scale.y = powerUpModifier

func _physics_process(delta: float) -> void:
	# PHYSICS
	timeSinceLastHit += delta
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * powerUpModifier
		animations.play("jump_straight")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED * powerUpModifier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	_updateAnimation(direction)
	
func _updateAnimation(direction: float) -> void:
	if (Input.is_action_just_pressed("jump") and is_on_floor()):
		animations.play("jump_straight")
	elif (direction > 0 && is_on_floor()):
		animations.play("walk_right")
	elif (direction < 0 && is_on_floor() ):
		animations.play("walk_left")
	elif (direction > 0):
		animations.play("jump_right")
	elif (direction < 0):
		animations.play("jump_left")
	else:
		animations.play("idle")
		
func playerChangeStage():
	self.scale.x = 1.5
	self.scale.y = 1.5
	print("Scale:", self.scale)
	print(powerUpModifier)

func takeDamage():
	if (timeSinceLastHit > INVULNERABILITY):
		print("Damage taken!")
		if (Global.hasPowerUp == false):
			get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		else:
			Global.hasPowerUp = false
			updateSize()
		# Global.changeStage(-1)
		timeSinceLastHit = 0

func _on_hit_detection_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Items")):
		body.consume()
		playerChangeStage()
	if (body.is_in_group("Enemy")):
		takeDamage()
	if (body.is_in_group("LethalObjects")):
		print("Lethal Objects triggered")
		takeDamage()
	

func _on_attack_detection_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Items")):
		body.consume()
	if (body.is_in_group("Enemy")):
		body.killed()
