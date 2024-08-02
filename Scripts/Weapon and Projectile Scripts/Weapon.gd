extends Node2D

@export var bullet_pref : PackedScene
@export var bullet_velocity:float=100
func _physics_process(delta):
	look_at(get_global_mouse_position())
	
func _input(event):
	if Input.is_action_just_pressed('shoot'):
		var bullet_instance=bullet_pref.instantiate()
		owner.owner.add_child(bullet_instance)
		bullet_instance.transform=$Firepoint.global_transform
