extends Area2D
@export var bullet_velocity:float = 400
@export var damage = 1 
func _physics_process(delta):
	position+=transform.x*bullet_velocity*delta

func _on_body_entered(body):
	if !body.is_in_group('Player'):
		queue_free()
		
	if body.is_in_group('Enemy'):
		body.change_health(-damage)
		
	
