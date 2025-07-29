extends Area2D

@export
var nextLevel: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# print(nextLevel)\
	pass

func nextScene() -> void:
	get_tree().change_scene_to_file(nextLevel)

func _on_body_entered(body: Node2D) -> void:
	print("victory")
	if (body.name == "Player" && nextLevel != ""):
		call_deferred("nextScene")