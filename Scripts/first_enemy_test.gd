extends CharacterBody2D

var speed = 20
var last_direction := Vector2(1,0)
var direction_x = 0
var direction_y = 0
var player_position
var target_position

@onready var player: CharacterBody2D = $"../Player"

func _physics_process(delta):
	print(player.position - position)
	player_position = player.position
	target_position = (player.position - position).normalized()
	velocity = target_position * speed
	if position.distance_to(player.position) > 3:
		move_and_slide()
		
	play_walk_animation (direction_x, direction_y)
	
#	else: 
#	play_idle_animation (last_direction)
func play_walk_animation (direction_x, direction_y):
	if direction_x > 0:
		$AnimatedSprite2D.play("walk_right")
	elif direction_x < 0:
		$AnimatedSprite2D.play("walk_left")
	elif direction_y > 0:
		$AnimatedSprite2D.play("walk_down")
	elif direction_y < 0:
		$AnimatedSprite2D.play("walk_up")
func play_idle_animation (direction):
	if direction.x > 0:
		$AnimatedSprite2D.play("idle_right")
	elif direction.x < 0:
		$AnimatedSprite2D.play("idle_left")
	elif direction.y > 0:
		$AnimatedSprite2D.play("idle_down")
	elif direction.y < 0:
		$AnimatedSprite2D.play("idle_up")
