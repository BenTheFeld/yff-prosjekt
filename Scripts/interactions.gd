extends Area2D

var can_interact: Array = []

func _on_body_entered(body):
	if body.has_method("interact"):
		can_interact.append(body)
		print("Interactable added: ", body.name)

func _on_body_exited(body):
	if can_interact.has(body):
		can_interact.erase(body)
		print("Interactable removed: ", body.name)

func _unhandled_input(event):
	if event.is_action_pressed("interact"):
		for obj in can_interact:
			obj.interact()
		if can_interact.size() > 0:
			print("Interacted!")
			get_tree().set_input_as_handled()   
