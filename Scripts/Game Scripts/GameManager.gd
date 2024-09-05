extends Node

@export var PlayerRef:CharacterBody2D
@export var UIRef:PackedScene

func _ready():
	var emitter = PlayerRef
	emitter.player_dead.connect(_player_dead)
	
func _restart_level():
	get_tree().root.reload_current_scene()

func _player_dead():
	var UIInstance=UIRef.instantiate()
	get_tree().root.add_child.call_deferred(UIInstance)

	
