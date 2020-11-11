extends KinematicBody2D

export var speed = 80 # vitesse du perso
var screen_size # taille de la fenêtre de jeu
var animation_idle = true
var direction = 1
const MOVE_ACTIONS = ["ui_right", "ui_left", "ui_up", "ui_down"]

func _ready():
	screen_size = get_viewport_rect().size
	
func start(pos):
	position = pos
	show()

func _process(delta):
	process_inputs(delta)

func process_inputs(delta):
	# fast return si action en cours
	if !animation_idle:
		return
	if is_move_action_pressed():
		move()
	elif Input.is_action_just_pressed("ui_select"):
		dash()

func move():
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
			velocity.x += 1
			direction = 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		direction = -1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		pass
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	move_and_slide(velocity, Vector2(0, 0))
	
	if velocity.x != 0 || velocity.y != 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0 # on flip si valeur negative
		pass
	else:
		$AnimatedSprite.animation = "stand" # position par défaut
	pass

func dash():
	animation_idle = false
	$AnimatedSprite.animation = "dash"
	$AnimatedSprite.play()
	
func die():
	$AnimatedSprite.animation = "die"
	$AnimatedSprite.play()
	pass
	
func is_move_action_pressed():
	return Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_up") || Input.is_action_pressed("ui_down")

######## Signals ########
func _on_AnimatedSprite_animation_finished():
	if ($AnimatedSprite.animation == "dash"):
		animation_idle = true
		position.x += 47 * direction
		$AnimatedSprite.animation = "stand"
