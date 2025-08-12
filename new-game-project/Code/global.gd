extends Node

# DEFAULT GAME STATE CONSTANTS
# Default game collision layers
# 1:player
# 2:enemies
# 3: powerup
# 4: fireballs
# 5: terrain

const FIRE_WOLFIE: Resource = preload("res://Art/Animations/Fire_Wolfie.tres")
const DEFAULT_WOLFIE: Resource = preload("res://Art/Animations/Default_Wolfie.tres")
const FLOATY_WOLFIE: Resource = preload("res://Art/Animations/Floaty_Wolfie.tres")
const STARTING_MONEY = 0
const STARTING_STAGE = 1
const NUM_OF_STAGES = 2

var player = null
var hasPowerUp = false
var hasProjectile = false
var current_money = 0
var stage = 1
var fallingModifier = 1
var lives = 1

func change_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)

func next_stage() -> void:
	assert(stage > 0, "Stage number can't be less than 1.")
	stage += 1
	print(stage)
	if (stage > NUM_OF_STAGES):
		print("complete!")
		call_deferred("change_scene", "res://Scenes/main_menu.tscn")
	else:
		print("Stage changed to " + str(stage))
		call_deferred("change_scene", "res://Scenes/Levels/level-" + str(stage) + ".tscn")
	
func reset_game_state() -> void:
	current_money = STARTING_MONEY
	stage = STARTING_STAGE
	hasPowerUp = false;

func reset_player() -> void:
	Global.hasPowerUp = false
	fallingModifier = 1
	hasProjectile = false
	lives = 1
	player.changeCostume(DEFAULT_WOLFIE)

func add_lives(amt: int):
	lives += amt

func _on_powerup_collected() -> void:
	hasPowerUp = true

func _change_fallingMod() -> void:
	fallingModifier = 0.95
	player.changeCostume(FLOATY_WOLFIE)

func _give_projectile() -> void:
	hasProjectile = true
	player.changeCostume(FIRE_WOLFIE)

func _on_player_damage_taken() -> void:
	if (Global.hasPowerUp == false):
		lives -= 1
		if (lives == 0):
			get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
		else:
			call_deferred("change_scene", "res://Scenes/Levels/level-" + str(stage) + ".tscn")
			reset_player()
	else:
		reset_player()
