extends PowerUP

func _ready() -> void:
    super._ready()
    powerup_collected.connect(Global._give_projectile)

func consume() -> void:
    super.consume()