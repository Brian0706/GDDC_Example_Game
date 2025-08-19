extends Control

@onready var pressStart: AudioStreamPlayer2D = $ButtonPress
@onready var timer: Timer = $Timer

func _on_button_pressed() -> void:
	print("'New Game' button pressed")
	Global.reset_game_state()
	pressStart.play()
	timer.start()


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level-1.tscn")
