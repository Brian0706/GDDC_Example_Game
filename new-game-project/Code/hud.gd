extends Control

# Variables for when the HUD is first created
@onready var coinLabel= $HBoxContainer/CoinLabel
@onready var stageLabel = $HBoxContainer/StageLabel
@onready var livesLabel = $HBoxContainer/LivesLabel

func _ready() -> void:
	updateLivesLabel()
	updateScoreLabel()
	updateStageLabel()

func updateScoreLabel():
	coinLabel.text = "Coins: " + str(Global.current_money)
	print("score updated")
	
func updateStageLabel():
	stageLabel.text = "Level: " + str(Global.stage)
	print("level updated")
	
func updateLivesLabel():
	livesLabel.text = "Lives: " + str(Global.lives)
	print("lives updated")
