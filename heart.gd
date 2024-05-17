extends Area2D

signal heart_collected

func _on_body_entered(body):
	heart_collected.emit()
	queue_free()
