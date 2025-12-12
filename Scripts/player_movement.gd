extends CharacterBody2D

var max_speed := 100
var last_direction := Vector2(1, 0)
var number := 0

@onready var bullet = preload("res://Scenes/bullet.tscn")
@onready var healthbar = $HealthBar

var can_shoot := true
var shoot_cooldown := 1.0  # seconds

func _ready():
	healthbar.init_health(100)

func shoot():
	var bullet_temp = bullet.instantiate()
	bullet_temp.position = position

	get_tree().root.add_child(bullet_temp)

	# Reset direction
	bullet_temp.direction_x = 0
	bullet_temp.direction_y = 0

	# Set direction based on movement
	match number:
		1: bullet_temp.direction_x = 1
		2: bullet_temp.direction_x = -1
		3: bullet_temp.direction_y = 1
		4: bullet_temp.direction_y = -1

func start_shoot_cooldown() -> void:
	can_shoot = false
	await get_tree().create_timer(shoot_cooldown).timeout
	can_shoot = true

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * max_speed
	move_and_slide()

	if Input.is_action_pressed("ui_accept") and can_shoot:
		shoot()
		start_shoot_cooldown()

	if direction.length() > 0:
		last_direction = direction
		play_walk_animation(direction)
	else:
		play_idle_animation(last_direction)

func play_walk_animation(direction):
	if direction.x > 0:
		$AnimatedSprite2D.play("walk_right")
		number = 1
	elif direction.x < 0:
		$AnimatedSprite2D.play("walk_left")
		number = 2
	elif direction.y > 0:
		$AnimatedSprite2D.play("walk_down")
		number = 3
	elif direction.y < 0:
		$AnimatedSprite2D.play("walk_up")
		number = 4

func play_idle_animation(direction):
	if direction.x > 0:
		$AnimatedSprite2D.play("idle_right")
	elif direction.x < 0:
		$AnimatedSprite2D.play("idle_left")
	elif direction.y > 0:
		$AnimatedSprite2D.play("idle_down")
	elif direction.y < 0:
		$AnimatedSprite2D.play("idle_up")

# --------------------
# COLLISION WITH ENEMY
# --------------------
func _on_hitbox_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		print("Collided with Enemy!")
		healthbar.health -= 10
