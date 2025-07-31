extends PowerUP

# var powerUPFuncs = PowerUP.new()

func _ready() -> void:
	super._ready()
	powerup_collected.connect(Global._change_fallingMod)

func consume() -> void:
	super.consume()