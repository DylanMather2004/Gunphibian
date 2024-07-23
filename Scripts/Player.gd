extends CharacterBody2D

@export var move_speed = 400
@export var jump_height = 400
@export var gravity = 3000
var jumpBuffer:float = 0.0
@export_range(0.0,1.0)var acceleration=0.25
@export_range(0.0,1.0)var friction=0.1
var direction = 0

		
	
func _physics_process(delta):
	
	if jumpBuffer > 0.0:
		jumpBuffer-=delta
		print(jumpBuffer)
	direction = Input.get_axis("Left","Right")
	if direction:
		velocity.x=lerp(velocity.x,direction*move_speed,acceleration)
	else:
		velocity.x=lerp(velocity.x,0.0,friction)
	velocity.y+=gravity*delta
	
	move_and_slide()
	
	if Input.is_action_just_pressed('Jump'):
		jumpBuffer=0.2
		
	if jumpBuffer>0.0&&is_on_floor():
		velocity.y=-jump_height
