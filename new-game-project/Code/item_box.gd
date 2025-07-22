extends Area2D
@export
var item: PackedScene
@export
var animation: AnimationPlayer

func _connect_item_to_signals(powerUP):
	powerUP.powerup_collected.connect($"../Player"._on_powerup_collected)
	powerUP.powerup_collected.connect(Global._on_powerup_collected)

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player" && item != null):
		animation.play("GetItem")
		var powerUP = item.instantiate();
		item = null
		add_child(powerUP)
		powerUP.position.y -= 20
		_connect_item_to_signals(powerUP)
		print("Item box triggered!")
