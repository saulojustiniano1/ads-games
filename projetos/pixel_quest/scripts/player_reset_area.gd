extends Area2D

@onready var audio_game_over = $"../AudioGameOver"

func _on_body_entered(body):
	GameManager.player_entered_reset_area()
	audio_game_over.play()
