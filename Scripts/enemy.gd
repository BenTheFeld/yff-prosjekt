extends AnimatedSprite2D

@onready var healthbar = $HealthBar

var health = 0

func _ready():
	health = 100
	healthbar.init_health(health)

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("bullet"):
		health -= 10
		$HealthBar.value = health   
