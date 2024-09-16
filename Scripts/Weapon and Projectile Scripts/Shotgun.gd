extends Weapon
@export var shots_per_spread = 5 

func _input(event):
	if equipped:
		if Input.is_action_just_pressed('shoot')&&can_fire:
			for i in range (shots_per_spread):
				_Shoot()
