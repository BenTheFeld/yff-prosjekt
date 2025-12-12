extends AnimatedSprite2D

@onready var healthbar = $HealthBar

var health = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	health = 100
	healthbar.init_health(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
