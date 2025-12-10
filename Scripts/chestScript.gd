extends AnimatedSprite2D

func interact():
	play("chest_open")
	set_process(false)  # Prevent re-triggering   
