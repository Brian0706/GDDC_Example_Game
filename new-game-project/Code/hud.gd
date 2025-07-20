extends Control
# Called when the node enters the scene tree for the first time.
@onready var coinLabel = $CanvasLayer/HBoxContainer/CoinLabel

func updateScoreLabel():
	coinLabel.text = "MONEY: " + str(Global.current_money)

func updateStageLabel():
	pass
	
