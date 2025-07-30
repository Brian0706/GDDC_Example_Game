extends CharacterBody2D

signal player_damage_taken

# DIRECTION CONSTANTS

#removed the enum stuff because we're just gonna use .flip_h lol



const SPEED = 350.0
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

func _connect_item_to_signals() -> void:
	self.player_damage_taken.connect(Global._on_player_damage_taken)

func _ready() -> void:
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
	_update_animation(direction)

func _update_animation(direction: float) -> void:
	var dir = int(sign(direction)) # maps any negative to –1, zero to 0, positive to +1
	if is_on_floor() && velocity.x == 0:
		animations.play("widle")
	elif is_on_floor() && velocity.x != 0:
		animations.play("wwalk")
	elif !is_on_floor() &&  (velocity.y > 0):
		animations.play("wjumpdown")
	elif !is_on_floor() && (velocity.y <= 0):
		animations.play("wjumpup")
	
	if velocity.x > 0:
		animations.flip_h = true
	if velocity.x < 0:
		animations.flip_h = false
	#Code here needs to get clean up (We need to decide how we update and track lives)
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
		Global.lives -= 1
		if (Global.hasPowerUp == false):
			get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
		else:
			Global.hasPowerUp = false
		$"../CanvasLayer/HUD".updateLivesLabel()
		_update_size()
		emit_signal("player_damage_taken")
		timeSinceLastHit = 0
		print("Damage taken!")


func _on_hit_detection_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Items")):
		body.consume()
		_update_size()
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
		print("Dealt damage!")
