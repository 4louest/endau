extends StaticBody2D

export var is_on = false


# TODO : 
#	- Coder un effet de clignottement pour simuler une lampe pétée
#	- Interagir avec la lampe pour l'allumer et l'éteindre
#	- Mettre un halo lumineux
func _process(delta):
	if (Input.is_action_just_pressed("switch_light")):
		is_on = !is_on
		switch_state()

func switch_state():
	if (is_on):
		$Sprite.region_rect = Rect2(Vector2(37, 186), Vector2(27, 22))
	else :
		$Sprite.region_rect = Rect2(Vector2(5, 186), Vector2(27, 22))
