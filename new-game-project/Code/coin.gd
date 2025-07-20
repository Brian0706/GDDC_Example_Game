extends Node2D

signal coin_collected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		Global.current_money += 1
		emit_signal("coin_collected")
		queue_free()
		$"../../CanvasLayer/HUD".updateScoreLabel()
		print("Picked up coin!")
