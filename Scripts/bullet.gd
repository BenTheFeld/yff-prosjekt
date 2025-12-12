extends Area2D

var speed = 300
var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var direction_y
var direction_x
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * direction_x*delta
	position.y += speed * direction_y*delta
