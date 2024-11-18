extends CanvasLayer

signal start_game


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func update_score(score):
	$ScoreLabel.text = str(score)
	

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func show_game_over():
	show_message('Game Over!')
	await $MessageTimer.timeout
	
	$MessageLabel.text = 'Unowns'
	$MessageLabel.show()
	
	$StartButton.show()

func _on_message_timer_timeout():
	$MessageLabel.hide()
