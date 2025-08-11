extends Enemy

@onready var respawnTimer: Timer = $Timer

func defeated(delta: float) -> void:
    if !animations.is_playing() and respawnTimer.is_stopped():
        respawnTimer.start()

func _on_timer_timeout() -> void:
    self.set_collision_layer_value(2, true)
    self.set_collision_layer_value(5, false)
    curState = 0
    print(states[curState])
