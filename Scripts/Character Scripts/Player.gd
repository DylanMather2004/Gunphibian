extends CharacterBody2D

@export var move_speed = 400
@export var jump_height = 400
@export var gravity = 3000
@export var fling_force = 500
@export var max_health = 10
@export var i_frames = 0.2
var invincible = false
var health 
var jumpBuffer:float = 0.0
@export_range(0.0,1.0)var acceleration=0.25
@export_range(0.0,1.0)var friction=0.1
var direction = 0
var end_point:Vector2 = Vector2.ZERO
var target:Node2D=null


var line_colour:Color = Color(255,0,0,0.5)
		
func _draw():
	if Input.is_action_pressed("Lick"):
		draw_line(to_local(global_position),to_local(end_point),line_colour,3,true)
		Engine.time_scale = 0.5
	
func _ready():
	health = max_health
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
	
	if Input.is_action_just_released("Lick"):
		Engine.time_scale = 1
		_fling_calculation()
	move_and_slide()
	if Input.is_action_just_pressed('Jump'):
		jumpBuffer=0.2
	if jumpBuffer>0.0&&is_on_floor():
		velocity.y=-jump_height
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position,get_global_mouse_position(),collision_mask,[self])
	query.collide_with_areas=true
	var result = space_state.intersect_ray(query)
	if result:
		end_point=result.position
		if result.collider.is_in_group('Lickable'):
			line_colour = Color(0,255,0,0.5)
			target=result.collider
		else:
			line_colour=Color(255,0,0,0.5)
			target=null
	else:
		line_colour=Color(255,0,0,0.5)
		end_point=get_global_mouse_position()
		target=null
	queue_redraw()
	
	
func _fling_calculation():
	if target !=null:
		var flingdir = (target.global_position-global_position).normalized()
		var flingvelocity =flingdir*fling_force
		
		velocity=flingvelocity
		
func change_health(change):
	if change<0&&invincible==false:
		health+=change
		start_i_frames()
	else:
		health+=change
	health = health.clampi(0,max_health)
	if health == 0: 
		_die()
func _die():
	pass

func start_i_frames():
	invincible=true
	$IFrameTimer.start(i_frames)
		
func _on_i_frame_timer_timeout():
	invincible=false 
