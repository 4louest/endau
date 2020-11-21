extends KinematicBody2D

const SPEED = 0

var movedir = Vector2(0,0)
var spritedir = "left"

func movement_loop():
	var motion = movedir.normalized() * SPEED
	move_and_slide(motion, Vector2(0,0))

func spritedir_loop():
	match movedir:
		Vector2(-1,0):
			spritedir = "left"
		Vector2(1,0):
			spritedir = "right"
		# todo up & down

func anime_switch(animation):
	var newanim = str(animation, spritedir)
	if $anim.curre
