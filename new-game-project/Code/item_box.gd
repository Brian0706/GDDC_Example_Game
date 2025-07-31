extends Area2D
@export
var item: PackedScene
@export
var animation: AnimationPlayer

@onready var sprite: AnimatedSprite2D = $Sprite2D

func _connect_item_to_signals(powerUP):
	add_child(powerUP)
	# Use the absolute path as paths relative to the scene can change during development
	powerUP.powerup_collected.connect($"/root/Controller/Player"._on_powerup_collected)
	powerUP.powerup_collected.connect(Global._on_powerup_collected)

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player" && item != null):
		animation.play("GetItem")
		var powerUP = item.instantiate();
		item = null
		call_deferred("_connect_item_to_signals", powerUP)
		powerUP.position.y -= 20
		print("Item box triggered!")
		sprite.play("opened")
