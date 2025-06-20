extends Area2D

func reset():
	get_tree().reload_current_scene()

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		print("defeat")
		call_deferred("reset")
