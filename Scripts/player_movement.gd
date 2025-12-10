extends CharacterBody2D

var max_speed = 100
var last_direction := Vector2(1, 0) # Initial facing direction (Right)

# --- Your genius number system for direction ---
# 1: Right, 2: Left, 3: Down, 4: Up
var number = 1 # Initialize to match last_direction (1=Right)

@onready var bullet = preload("res://scenes/bullet.tscn")

# --- Shooting cooldown ---
var can_shoot := true
var shoot_cooldown := 0.5 # seconds between shots

# --- Helper function to update 'number' and return direction ---
func get_cardinal_direction_number(direction: Vector2) -> int:
	# Prioritize the axis with the largest magnitude
	if abs(direction.x) >= abs(direction.y):
		if direction.x > 0:
			return 1 # Right
		elif direction.x < 0:
			return 2 # Left
	
	# If horizontal movement was zero or smaller
	if direction.y > 0:
		return 3 # Down
	elif direction.y < 0:
		return 4 # Up
	
	# Fallback (Should only happen if direction is exactly (0,0))
	return number

func shoot():
	var bullet_temp = bullet.instantiate()
	bullet_temp.position = position
	get_tree().get_root().add_child(bullet_temp)
	
	# Set bullet direction using the stored 'number'
	bullet_temp.direction_x = 0
	bullet_temp.direction_y = 0
	
	if number == 1:
		bullet_temp.direction_x = 1
	elif number == 2:
		bullet_temp.direction_x = -1
	elif number == 3:
		bullet_temp.direction_y = 1
	elif number == 4:
		bullet_temp.direction_y = -1

func start_shoot_cooldown():
	can_shoot = false
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true

@warning_ignore("unused_parameter")
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * max_speed
	move_and_slide()

	var is_shooting = false
	
	# --- Handling Shoot Input ---
	if Input.is_action_pressed("ui_accept") and can_shoot:
		shoot()
		start_shoot_cooldown()
		play_shoot_animation(last_direction)
		is_shooting = true
	
	# --- Movement and Animation ---
	if not is_shooting:
		if direction.length() > 0:
			last_direction = direction
			play_walk_animation(direction)
		else:
			# FIX: Set number even when idle to ensure correct shooting direction
			number = get_cardinal_direction_number(last_direction) 
			play_idle_animation(last_direction)

func play_walk_animation(direction):
	number = get_cardinal_direction_number(direction)

	if number == 1:
		$AnimatedSprite2D.play("walk_right")
	elif number == 2:
		$AnimatedSprite2D.play("walk_left")
	elif number == 3:
		$AnimatedSprite2D.play("walk_down")
	elif number == 4:
		$AnimatedSprite2D.play("walk_up")

func play_idle_animation(direction):
	if direction.x > 0:
		$AnimatedSprite2D.play("idle_right")
	elif direction.x < 0:
		$AnimatedSprite2D.play("idle_left")
	elif direction.y > 0:
		$AnimatedSprite2D.play("idle_down")
	elif direction.y < 0:
		$AnimatedSprite2D.play("idle_up")

func play_shoot_animation(direction):
	if direction.x > 0:
		$AnimatedSprite2D.play("shoot_right")
	elif direction.x < 0:
		$AnimatedSprite2D.play("shoot_left")
	elif direction.y > 0:
		$AnimatedSprite2D.play("shoot_down")
	elif direction.y < 0:
		$AnimatedSprite2D.play("shoot_up")
