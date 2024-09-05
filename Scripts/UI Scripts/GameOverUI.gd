extends CanvasLayer


func _on_retry_button_pressed():
	get_tree().reload_current_scene()
	queue_free()


func _on_quit_button_pressed():
	get_tree().quit()
