extends Area2D


func _on_body_entered(body):
	if body.is_in_group('Player'):
		var dequeue = get_tree().get_nodes_in_group('Enemy')
		for i in (dequeue.size()-1):
			dequeue[i].queue_free()
			 
		get_tree().reload_current_scene()
