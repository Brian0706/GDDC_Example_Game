extends PowerUP


func _ready() -> void:
	print($"/root/Controller/CanvasLayer/HUD")

func consume():
	Global.add_lives(1)
	super.consume()
