extends Node2D

var rng = RandomNumberGenerator.new()
@export var Enemies = []

func _spawn(enemy:PackedScene):
	var enemy_instance:Node2D=enemy.instantiate()
	enemy_instance.global_position=position
	owner.add_child.call_deferred(enemy_instance)
	print(enemy_instance)
	
func _ready():
	rng.randomize()
	_spawn(Enemies[rng.randi_range(0,Enemies.size()-1)])
