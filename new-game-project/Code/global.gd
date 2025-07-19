extends Node

var player = null
var lives = 3
var money = 0
var stage = 1

func changeStage(change: int) -> void:
	stage += change
	if (stage == 0):
		get_tree().reload_current_scene()
		stage = 1
		lives -= 1
	player.changeStage()
