extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		Global.hasPowerUp = false
		Global._on_player_damage_taken()
	else:
		body.queue_free()
