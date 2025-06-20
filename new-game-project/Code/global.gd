extends Node

var player = null
var lives = 10
var money = 0
var stage = 1

func changeStage(change: int) -> void:
    stage += change
    player.changeStage()