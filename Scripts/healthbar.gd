extends ProgressBar

<<<<<<< Updated upstream
@onready var timer = $Timer
@onready var damage_bar = $DamageBar

const SMOOTH_SPEED := 24.0

var health := 0 : set = _set_health
var target_health := 0  # used for delayed animation

func _process(delta):
	if damage_bar.value > value:
		damage_bar.value = move_toward(damage_bar.value, value, SMOOTH_SPEED * delta)

func _set_health(new_health):
	health = clamp(new_health, 0, max_value)
	value = health  # update instantly

	if health < target_health:
		timer.start()

func init_health(start_health):
	health = start_health
	target_health = start_health
	max_value = start_health

	value = start_health
	damage_bar.max_value = start_health
	damage_bar.value = start_health

func _on_timer_timeout():
	target_health = value
=======
@onready var damage_bar = $DamageBar  # Må være en ProgressBar bak

var health: float = 100:
	set = _set_health
func _ready():
	init_health(100)
# Simuler skade etter 1 sekund
	#await get_tree().create_timer(1.0).timeout
	#_set_health(50)   
# Kall denne fra _ready() i spiller/enemy
func init_health(starting_health: float):
	health = starting_health
	max_value = starting_health
	value = starting_health
	damage_bar.max_value = starting_health
	damage_bar.value = starting_health

func _set_health(new_health: float):
	health = clamp(new_health, 0, max_value)
	value = health  # Umiddelbar helse (grønn bar)

func _process(delta):
	# Følger sakte etter
	if damage_bar.value > health:
		damage_bar.value = move_toward(damage_bar.value, health, 50 * delta)   
>>>>>>> Stashed changes
