extends Control
@onready var lostSound: AudioStreamPlayer2D = $GameLost
@onready var buttonPress: AudioStreamPlayer2D = $ButtonPress
@onready var transitionTimer: Timer = $Timer

var newScene = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lostSound.play()

func _on_retry_button_pressed() -> void:
	Global.reset_game_state()
	newScene = "res://Scenes/Levels/level-1.tscn"
	buttonPress.play()
	transitionTimer.start()
	print("Rety button pressed")

func _on_main_menu_button_pressed() -> void:
	newScene = "res://Scenes/main_menu.tscn"
	transitionTimer.start()
	buttonPress.play()
	print("Main menu button pressed")


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file(newScene)
