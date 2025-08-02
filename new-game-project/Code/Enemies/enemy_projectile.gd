extends CharacterBody2D

const SPEED = 500.0
const JUMP_VELOCITY = -250.0
const INVULNERABILITY = 0.5
var direction = 1

func _physics_process(delta: float) -> void:
    velocity.x = SPEED * direction
    move_and_slide()
    
func _on_object_life_span_timeout() -> void:
    self.queue_free()
