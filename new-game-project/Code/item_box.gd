extends Area2D
@export
var item: PackedScene
@export
var animation: AnimationPlayer
func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player" && item != null):
		animation.play("GetItem")
		var powerUP = item.instantiate();
		item = null
		add_child(powerUP)
		powerUP.position.y -= 20
		print("got item!")
		Global.hasPowerUp = true
