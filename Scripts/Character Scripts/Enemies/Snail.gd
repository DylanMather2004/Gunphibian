extends "res://Scripts/Character Scripts/Enemies/Enemy.gd"

var direction=-1
@export var _move_speed = 30
@export var _gravity = 500



func _physics_process(delta):
	if !is_on_floor():
		velocity.y+=_gravity*delta
		
	velocity.x=direction*_move_speed
	
	move_and_slide()

func change_health(change):
	super.change_health(change)
	#if change <0: 
		#$AnimationPlayer.play("hurt")

func _on_area_2d_body_entered(body):
	if body == self:
		print('HIT')
	if !body.is_in_group('Player')&&body!=self:
		direction*=-1
		$Sprite2D.scale.x *= -1


func _on_hurtbox_body_entered(body):
	damage(body)
	


func _on_hurtbox_area_entered(area):
	if area.is_in_group('Bullet'):
		print('hit')
		$AnimationPlayer.play("hurt")
