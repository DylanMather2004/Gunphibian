extends Weapon

func _input(event):
	pass 

func _process(delta):
	if equipped:
		if Input.is_action_pressed("shoot")&&can_fire:
			_Shoot()
