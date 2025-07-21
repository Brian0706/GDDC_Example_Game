extends Node

# DEFAULT GAME STATE CONSTANTS

const STARTING_MONEY = 0
const STARTING_STAGE = 1

var player = null
var hasPowerUp = false
var current_money = 0
var stage = 1

func changeStage(change: int) -> void:
	print("Change stage is called.")
	stage += change
	if (stage == 0):
		get_tree().reload_current_scene()
		stage = 1
		#current_lives -= 1
	player.playerChangeStage()
	
func reset_game_state() -> void:
	current_money = STARTING_MONEY
	stage = STARTING_STAGE
	hasPowerUp = false;

func death_handler() -> void:
	pass
