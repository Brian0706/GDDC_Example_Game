extends CharacterBody2D

var powerUPFuncs = PowerUP.new()

func _ready() -> void:
    powerUPFuncs._ready()

func consume() -> void:
    powerUPFuncs.consume()