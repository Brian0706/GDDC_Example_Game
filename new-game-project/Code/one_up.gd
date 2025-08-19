extends PowerUP


func _ready() -> void:
    powerup_collected.connect($"/root/Controller/CanvasLayer/HUD".updateLivesLabel)

func consume():
    Global.add_lives(1)
    super.consume()
