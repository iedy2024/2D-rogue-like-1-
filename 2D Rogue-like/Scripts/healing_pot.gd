extends Area2D
signal health_recived
func _on_body_entered(_body):
	emit_signal("health_recived", 10)
	queue_free()
