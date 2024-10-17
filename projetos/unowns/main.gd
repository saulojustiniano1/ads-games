extends Node

@export var enemy_scene: PackedScene
var score

func _ready():
	new_game()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func game_over():
	$ScoreTimer.stop()
	$EnemyTimer.stop()

func _on_enemy_timer_timeout():
	pass

func _on_score_timer_timeout():
	score += 1

func _on_start_timer_timeout():
	$EnemyTimer.start()
	$ScoreTimer.start()
