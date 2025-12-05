extends CharacterBody2D

var speed = 100
var last_direction := Vector2(1,0)

@onready var player: CharacterBody2D = $"."

func _physics_process(delta):
	var direction = (player.position-position).normalized()
	velocity = direction * speed
	look_at(player.position)
	move_and_slide()
	
	
	if direction.length() > 0:
		last_direction = direction
		play_walk_animation (direction)
	
	else: 
		play_idle_animation (last_direction)
func play_walk_animation (direction):
	if direction.x > 0:
		$AnimatedSprite2D.play("walk_right")
	elif direction.x < 0:
		$AnimatedSprite2D.play("walk_left")
	elif direction.y > 0:
		$AnimatedSprite2D.play("walk_down")
	elif direction.y < 0:
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
