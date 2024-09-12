class_name Weapon
extends Node2D

@export var bullet_pref : PackedScene
@export var damage=2
@export var bullet_velocity:float=100
@export var equipped = false
var rng = RandomNumberGenerator.new()
var can_fire = true
@export var fire_rate = 0.2
@export var bullet_spread = 0.1
func _ready():
	$Sprite.visible = equipped
func _physics_process(delta):
	if equipped:
		look_at(get_global_mouse_position())
	
func _input(event):
	if equipped:
		if Input.is_action_just_pressed('shoot')&&can_fire:
			_Shoot()

func _Equip():
	can_fire= true
	equipped = not equipped
	$Sprite.visible = equipped
func _Shoot():
	var bullet_instance:Node2D=bullet_pref.instantiate()
	owner.owner.add_child(bullet_instance)
	bullet_instance.transform=$Firepoint.global_transform
	rng.randomize()
	bullet_instance.rotation += rng.randf_range(-bullet_spread,bullet_spread)
	$ShotTimer.start(fire_rate)
	can_fire=false
	


func _on_shot_timer_timeout():
	can_fire=true
