extends Area2D

var speed = 300
var direction_y = 0
var direction_x = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * direction_x*delta
	position.y += speed * direction_y*delta
