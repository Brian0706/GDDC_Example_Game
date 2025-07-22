extends Node

# DEFAULT GAME STATE CONSTANTS

const STARTING_MONEY = 0
const STARTING_STAGE = 1

var player = null
var hasPowerUp = false
var current_money = 0
var stage = 1

func changeStage(stageNum: int) -> void:
	assert(stageNum < 1, "Stage number can't be less than 1.")		
	stage = stageNum
	print("Stage changed to " + str(stageNum))
	
func reset_game_state() -> void:
	current_money = STARTING_MONEY
	stage = STARTING_STAGE
	hasPowerUp = false;

func death_handler() -> void:
	pass
