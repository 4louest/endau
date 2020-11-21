extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var FRICTION = 500

export var speed = 80 # vitesse du perso
var screen_size # taille de la fenêtre de jeu
var animation_idle = true
var direction = 1

enum {
	MOVE,
	DASH,
	ATTACK
}
var state = MOVE
var velocity = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	
func start(pos):
	position = pos
	show()

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		DASH:
			dash_state()
		ATTACK:
			attack_state()


func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, delta * ACCELERATION)
	else:
		# idle
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
	
	move()
	
#	if Input.is_action_just_pressed("dash"):
#		state = DASH
	
func move():
	velocity = move_and_slide(velocity)

func dash_state():
	pass
	
func attack_state():
	pass

#func _process(delta):
#	process_inputs(delta)

#func process_inputs(delta):
#	# fast return si action en cours
#	if !animation_idle:
#		return
#	if is_move_action_pressed():
#		move()
#	elif Input.is_action_just_pressed("ui_select"):
#		dash()

#func move():
#	var velocity = Vector2()
#	if Input.is_action_pressed("ui_right"):
#			velocity.x += 1
#			direction = 1
#	if Input.is_action_pressed("ui_left"):
#		velocity.x -= 1
#		direction = -1
#	if Input.is_action_pressed("ui_up"):
#		velocity.y -= 1
#	if Input.is_action_pressed("ui_down"):
#		velocity.y += 1
#		pass
#
#	if velocity.length() > 0:
#		velocity = velocity.normalized() * speed
#		$AnimatedSprite.play()
#	else:
#		$AnimatedSprite.stop()
#
#	move_and_slide(velocity, Vector2(0, 0))
#
#	if velocity.x != 0 || velocity.y != 0:
#		$AnimatedSprite.animation = "run"
#		$AnimatedSprite.flip_v = false
#		$AnimatedSprite.flip_h = velocity.x < 0 # on flip si valeur negative
#		pass
#	else:
#		$AnimatedSprite.animation = "stand" # position par défaut
#	pass

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
