extends Area2D
@export
var item: String
@export
var animation: AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	print("got item!")
	animation.play("GetItem")
	if (body.name == "Player" && item != ""):
		print("got item!")
