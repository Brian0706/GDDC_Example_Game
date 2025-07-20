extends Area2D

var hadPowerUP = false;

func reset():
	if (hadPowerUP):
		get_tree().reload_current_scene()
	pass

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		if (Global.hasPowerUp):
			hadPowerUP = true
		call_deferred("reset")
		body.takeDamage()
