extends Area2D
var item: String

func _on_body_entered(body: Node2D) -> void:
	print("got item!")
	if (body.name == "Player" && item != ""):
		print("got item!")
