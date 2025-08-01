extends Node

# DEFAULT GAME STATE CONSTANTS
# Default game collision layers
# 1:player
# 2:enemies
# 3: powerup
# 4: fireballs
# 5: terrain

const STARTING_MONEY = 0
const STARTING_STAGE = 1

var player = null
var hasPowerUp = false
var hasProjectile = false
var current_money = 0
var stage = 1
var fallingModifier = 1

func changeStage(stageNum: int) -> void:
	assert(stageNum < 1, "Stage number can't be less than 1.")
	stage = stageNum
	print("Stage changed to " + str(stageNum))
	stageNum += 1
	
func reset_game_state() -> void:
	current_money = STARTING_MONEY
	stage = STARTING_STAGE
	hasPowerUp = false;

func death_handler() -> void:
	pass
	
func _on_powerup_collected() -> void:
	hasPowerUp = true

func _change_fallingMod() -> void:
	fallingModifier = 0.95

func _give_projectile() -> void:
	hasProjectile = true

func _on_player_damage_taken() -> void:
	if (Global.hasPowerUp == false):
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	else:
		Global.hasPowerUp = false
		fallingModifier = 1
		hasProjectile = false
