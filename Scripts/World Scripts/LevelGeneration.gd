extends Node2D

@export var Rooms = []
@export var CurrentRoom:Node2D
@export var number_of_rooms = 10
var rng = RandomNumberGenerator.new()

func _spawn(roomID):
	var room_to_spawn:Node2D = Rooms[roomID].instantiate()
	room_to_spawn.position = CurrentRoom.get_child(0).get_global_position()
	add_child(room_to_spawn)
	CurrentRoom=room_to_spawn
func _ready():
	for n in number_of_rooms:
		rng.randomize()
		var roomID=rng.randi_range(0,Rooms.size()-1)
		_spawn(roomID)
