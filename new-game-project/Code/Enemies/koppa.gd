extends Enemy

@onready var respawnTimer: Timer = $Timer
@onready var itemMode: AnimatedSprite2D = $ShellMode

func killed():
    if curState != len(states) - 1:
        self.set_collision_layer_value(2, false)
        self.set_collision_layer_value(5, true)
        animations.visible = false
        itemMode.visible = true
        curState = len(states) - 1
        respawnTimer.start()

func defeated(delta: float) -> void:
    pass

func _on_timer_timeout() -> void:
    self.set_collision_layer_value(2, true)
    self.set_collision_layer_value(5, false)
    animations.visible = true
    itemMode.visible = false
    curState = 0
