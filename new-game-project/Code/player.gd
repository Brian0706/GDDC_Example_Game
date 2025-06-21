extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = -500.0
const invulnerability = 0.5
var timeSinceLastHit = 1

func _physics_process(delta: float) -> void:
	timeSinceLastHit += delta
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY * (1 + (Global.stage - 1) / 2.0)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED * (1 + (Global.stage - 1) / 2.0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func changeStage():
	self.scale.x = (1 + (Global.stage - 1) / 2.0)
	self.scale.y = (1 + (Global.stage - 1) / 2.0)

func takeDamage():
	if (timeSinceLastHit > invulnerability):
		print("ouch")


func _on_hit_detection_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Items")):
		body.consume()
