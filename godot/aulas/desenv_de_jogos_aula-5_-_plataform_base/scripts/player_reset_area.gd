extends Area2D


func _on_body_entered(body):
	GameManager.player_entered_reset_area()
