extends AnimatedSprite2D

@onready var animations: AnimatedSprite2D = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func interact() -> void:
	animations.play("chest_open")
