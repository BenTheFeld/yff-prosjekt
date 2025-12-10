# Chest.gd
extends Area2D

# Variable to prevent the chest from being opened multiple times
var is_open: bool = false 

# --- Signal Connection Functions (Must be connected in the Godot Editor) ---

func _on_body_entered(body: Node2D):
	# Check if the entering body is the player (assuming player is in "player" group)
	if body.is_in_group("player"):
		# Tell the player *which* chest they can interact with
		body.set_interactable_chest(self)
		
func _on_body_exited(body: Node2D):
	if body.is_in_group("player"):
		# Tell the player they are no longer near this chest
		body.clear_interactable_chest()


# Public function for the Player to call to initiate opening
func open():
	if not is_open:
		is_open = true
		
		# Get the AnimatedSprite2D child node and play the required animation
		# Assuming the AnimatedSprite2D child is named "AnimatedSprite2D"
		var sprite = $AnimatedSprite2D
		sprite.play("open_chest")
		
		# Optional: Wait for the animation to finish
		await sprite.animation_finished
		
		# Add logic for spawning loot, playing sound, etc., here
		print("Chest content unlocked!")
