class_name PowerUP extends CharacterBody2D

signal powerup_collected

const SPEED = 300.0
var direction = 1

func _ready() -> void:
	# Use the absolute path as paths relative to the scene can change during development
	powerup_collected.connect($"/root/Controller/Player"._on_powerup_collected)
	powerup_collected.connect(Global._on_powerup_collected)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_wall():
		direction *= -1
	velocity.x = direction * SPEED

	move_and_slide()

func consume():
	emit_signal("powerup_collected")
	call_deferred("queue_free")
	print("Special item picked up!")
