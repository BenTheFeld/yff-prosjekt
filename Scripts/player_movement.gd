extends CharacterBody2D

var max_speed = 100
var last_direction := Vector2(1, 0)
var number = 0
var health = 0

@onready var bullet = preload("res://Scenes/bullet.tscn")
@onready var healthbar = $HealthBar
# --- Shooting cooldown ---
var can_shoot := true
var shoot_cooldown := 1   # seconds between shots

	

func _ready():
	health = 100
	healthbar.init_health(health)
	
func shoot():
	var bullet_temp = bullet.instantiate()
	
	# Spawn bullet at player position (you can add an offset later)
	bullet_temp.position = position

	get_tree().get_root().add_child(bullet_temp)

	# Reset bullet direction
	bullet_temp.direction_x = 0
	bullet_temp.direction_y = 0

	# Mitt geni nummersystem
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

	# --- Holding shoot button, with delay ---
	if Input.is_action_pressed("ui_accept") and can_shoot:
		shoot()
		start_shoot_cooldown()

	# Movement + animation
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

func play_shoot_animation(direction):
	if direction.x > 0:
		$AnimatedSprite2D.play("shoot_right") 
	elif direction.x < 0:
		$AnimatedSprite2D.play("shoot_left")
	elif direction.y > 0:
		$AnimatedSprite2D.play("shoot_down")
	elif direction.y < 0:
		$AnimatedSprite2D.play("shoot_up")


func _on_interactions_body_exited(body: Node2D) -> void:
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		print("Collided")
		health = health - 10
		healthbar.value = health  # ← Add this line
