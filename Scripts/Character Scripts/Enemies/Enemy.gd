extends CharacterBody2D

var _health = 5
@export var _max_health = 5

func _ready():
	_health=_max_health
	
func change_health(change):
	_health += change
	_health = clampi(_health,0,_max_health)
	if _health==0:
		queue_free()
