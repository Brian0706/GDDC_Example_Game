extends Area2D
@export
var item: PackedScene
@export
var animation: AnimationPlayer

@onready var sprite: AnimatedSprite2D = $Sprite2D

func add_powerUP(powerUP):
	add_child(powerUP)


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player" && item != null):
		animation.play("GetItem")
		var powerUP = item.instantiate();
		item = null
		call_deferred("add_powerUP", powerUP)
		powerUP.position.y -= 20
		print("Item box triggered!")
		sprite.play("opened")
