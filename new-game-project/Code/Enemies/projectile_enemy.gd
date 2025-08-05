class_name ProjectileEnemy extends Enemy

const projectile = preload("res://Scenes/Enemies/enemy_projectile.tscn")
@onready var projectile_timer: Timer = $ProjectileTimer

func killed():
    super.killed()
    projectile_timer.stop()

func attack(delta: float) -> void:
    var attack = projectile.instantiate()
	#Needed to prevent projectiles from moving with player
    get_parent().add_child(attack)
    attack.position.x = self.position.x
    attack.position.y = self.position.y
    attack.direction = direction
    curState = 3

func followThrough(delta: float) -> void:
    projectile_timer.start()
    curState = 0

func _ready() -> void:
    super._ready()
    states.append(Callable(self, "attack"))
    states.append(Callable(self, "followThrough"))

func _on_projectile_timer_timeout() -> void:
    curState = 2