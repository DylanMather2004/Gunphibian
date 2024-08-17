extends "res://Scripts/Character Scripts/Enemies/Enemy.gd"

enum STATES {IDLE,PATROL,SHOOT}
@export var state=STATES.PATROL

var direction = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var target:Node2D = null
@export var wait_time=2
var current_time=0
@export var fire_rate = 2
@export var move_speed = 200
var can_fire = false
@export var stinger_pref:PackedScene

func _physics_process(delta):
	match state:
		STATES.IDLE:
			current_time+=delta
			if current_time>=wait_time:
				_set_dir()
				current_time=0
				state=STATES.PATROL
		STATES.PATROL:
			velocity=direction*move_speed
			move_and_slide()
			current_time+=delta
			if current_time>=wait_time:
				current_time=0
				state=STATES.IDLE
		STATES.SHOOT:
			$StingPoint.look_at(target.global_position)
			if can_fire:
				_shoot()
				
			
			
func _set_dir():
	rng.randomize()
	var x=rng.randf_range(-1.0,1.0)
	rng.randomize()
	var y=rng.randf_range(-1.0,1.0)
	direction=Vector2(x,y)
	 
func _shoot():
	var stinger = stinger_pref.instantiate()
	get_tree().root.add_child(stinger)
	stinger.transform = $StingPoint.global_transform
	can_fire=false
	$ShotTimer.start(fire_rate)
	print(stinger)


func _on_detection_radius_body_entered(body):
	if body.is_in_group("Player"):
		target=body
		can_fire=false
		$ShotTimer.start(fire_rate)
		state=STATES.SHOOT


func _on_detection_radius_body_exited(body):
	if body.is_in_group("Player"):
		target=null
		state=STATES.IDLE


func _on_shot_timer_timeout():
	can_fire=true


func _on_wall_checker_body_entered(body):
	if state == STATES.PATROL:
		direction = -direction
