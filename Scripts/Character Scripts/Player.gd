extends CharacterBody2D

@export var move_speed = 400
@export var jump_height = 400
@export var charge_jump_height = 600
@export var gravity = 3000
@export var fling_force = 500
@export var max_health = 10
@export var i_frames = 0.2
@export_range(1,3)var current_weapon=0
var invincible = false
var health 
var grappling=false
var paused = false
var actual_friction
var jumpBuffer:float = 0.0
@export_range(0.0,1.0)var acceleration=0.25
@export_range(0.0,1.0)var friction=0.1
@export_range(0.0,1.0)var grapple_friction=0.01
var direction = 0

var charge=0 
enum player_states{BASE,CHARGEJUMP}
var state = player_states.BASE
@export var weapons:Array[Node2D]

signal player_dead

func _ready():
	health = max_health
	weapons[0]._Equip()
	actual_friction=friction
	
func _physics_process(delta):
	if paused == false:
		if invincible:
			if !$AnimationPlayer.is_playing():
				$AnimationPlayer.play("IFrame")
		if jumpBuffer > 0.0:
			jumpBuffer-=delta
		
		direction = Input.get_axis("Left","Right")
		if direction:
			velocity.x=lerp(velocity.x,direction*move_speed,acceleration)
		else:
			velocity.x=lerp(velocity.x,0.0,actual_friction)
		if !is_on_floor():
			velocity.y+=gravity*delta
		match state:
			player_states.BASE:
				_move_input()
				print('base')
			player_states.CHARGEJUMP:
				velocity.x=0
				print('charge')
				if Input.is_action_pressed("Charge-Jump"):
					charge+=delta
				if Input.is_action_just_released("Charge-Jump"):
					if charge>=2:
						velocity.y=-charge_jump_height
					charge=0
					state=player_states.BASE
		move_and_slide()
		if jumpBuffer>0.0&&is_on_floor():
			velocity.y=-jump_height

func _move_input():
	if state==player_states.BASE:
		direction = Input.get_axis("Left","Right")
	if direction:
		velocity.x=lerp(velocity.x,direction*move_speed,acceleration)
	else:
		velocity.x=lerp(velocity.x,0.0,actual_friction)
	if Input.is_action_just_pressed('Jump'):
			jumpBuffer=0.2




func change_health(change):
	if change<0&&invincible==false:
		health+=change
		$AnimationPlayer.play("Hurt")
		start_i_frames()
	else:
		health+=change
	health = clampi(health,0,max_health)
	if health == 0: 
		_die()
func _die():
	emit_signal('player_dead')
	paused=true

func start_i_frames():
	invincible=true
	$IFrameTimer.start(i_frames)
	
		
func _on_i_frame_timer_timeout():
	invincible=false
	$AnimationPlayer.play("base")

func _input(event):
	if Input.is_action_just_pressed('Weapon-Swap-Down'):
		weapons[current_weapon-1]._Equip()
		current_weapon+=1
		if current_weapon>weapons.size():
			current_weapon=1
		weapons[current_weapon-1]._Equip()
		
	if Input.is_action_pressed("Charge-Jump"):
		state=player_states.CHARGEJUMP

