extends Area2D

var speed = 300
var direction_x = 0
var direction_y = 0

func _ready():
	add_to_group("bullet")

func _process(delta):
	position += Vector2(direction_x, direction_y) * speed * delta
