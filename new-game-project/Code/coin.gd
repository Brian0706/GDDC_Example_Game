extends Node2D

signal coin_collected
@onready var coinPickUp: AudioStreamPlayer2D = $CoinPickUp
@onready var timer: Timer = $Timer
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		Global.current_money += 1
		print("test")
		coinPickUp.play()
		timer.start()
		animationPlayer.play("collected")
		emit_signal("coin_collected")
		$"../../CanvasLayer/HUD".updateScoreLabel()
		print("Picked up coin!")


func _on_timer_timeout() -> void:
	queue_free()
