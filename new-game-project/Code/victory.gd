extends Area2D

@export
var nextLevel: String

func nextScene() -> void:
	get_tree().change_scene_to_file(nextLevel)

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		Global.nextStage()