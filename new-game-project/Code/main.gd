extends Node


func _ready() -> void:
	Global.player = get_node("Player");
	for coin in get_tree().get_nodes_in_group("Coins"):
		coin.coin_collected.connect($"../CanvasLayer/HUD"._on_coin_collected)

# func _process(delta: float) -> void:
# 	pass
