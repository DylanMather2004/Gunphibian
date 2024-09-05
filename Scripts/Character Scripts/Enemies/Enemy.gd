extends CharacterBody2D

var _health = 5
@export var _max_health = 5
@export var _damage = 2
@export var hurt_animator:AnimationPlayer

func _ready():
	_health=_max_health
	
func change_health(change):
	_health += change
	_health = clampi(_health,0,_max_health)
	if change <0&&hurt_animator: #<-------- For Enemy Prototyping, remove in final build
		hurt_animator.play('hurt')#<-------- IMPORTANT: All Enemy hurt animations must be called 'Hurt' 
	if _health==0:
		queue_free()

func damage(target):
	if target.is_in_group('Player'):
		target.change_health(-_damage)
	
