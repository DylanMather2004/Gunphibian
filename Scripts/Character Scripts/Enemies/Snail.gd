extends "res://Scripts/Character Scripts/Enemies/Enemy.gd"

var direction=-1
@export var _move_speed = 30
@export var _gravity = 500



func _physics_process(delta):
	if !is_on_floor():
		velocity.y+=_gravity
		
	velocity.x=direction*_move_speed
	move_and_slide()
	


func _on_area_2d_body_entered(body):
	if body == self:
		print('HIT')
	if !body.is_in_group('Player')&&body!=self:
		direction*=-1
		$Sprite2D.scale.x *= -1
