extends Area2D

@onready var levelClear: AudioStreamPlayer = $ClearLevel
@onready var timer: Timer = $PlaySound

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		levelClear.play()
		timer.start()

func _on_play_sound_timeout() -> void:
	Global.next_stage()
