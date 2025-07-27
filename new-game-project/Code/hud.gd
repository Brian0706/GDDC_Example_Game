extends Control
# Called when the node enters the scene tree for the first time.
@onready var coinLabel = $CanvasLayer/HBoxContainer/CoinLabel
@onready var stageLabel = $CanvasLayer/HBoxContainer/StageLabel
@onready var livesLabel = $CanvasLayer/HBoxContainer/LivesLabel

# Updates respective labels when prompted

func updateScoreLabel():
	coinLabel.text = "COINS: " + str(Global.current_money)

func updateStageLabel():
	stageLabel.text = "STAGE - " + str(Global.stage)

func updateLivesLabel():
	livesLabel.text = "Lives: " + '2' if Global.hasPowerUp else '1'
