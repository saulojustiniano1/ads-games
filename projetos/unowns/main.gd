extends Node

@export var enemy_scene: PackedScene

const power_up_scene = preload("res://power_up.tscn")
const bomb_scene = preload("res://bomb.tscn")

var score


func new_game():
	score = 0
	get_tree().call_group('enemy', 'queue_free')
	get_tree().call_group('bomb', 'queue_free')
	get_tree().call_group('power_up', 'queue_free')
	$HUD.update_score(score)
	$HUD.show_message('Get Ready!')
	$Player.start($StartPosition.position)
	$MusicAudio.play()
	$StartTimer.start()


func game_over():
	$ScoreTimer.stop()
	$EnemyTimer.stop()
	$BombTimer.stop()
	
	$HUD.show_game_over()
	
	$MusicAudio.stop()
	$DeathAudio.play()


func _on_enemy_timer_timeout():
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	
	var enemy_spawn_position = $EnemyPath/EnemySpawnPosition
	enemy_spawn_position.progress_ratio = randf()
	
	var diretion = enemy_spawn_position.rotation + PI / 2
	diretion += randf_range(-PI / 4, PI / 2)
	
	enemy.position = enemy_spawn_position.position
	enemy.rotation = diretion
	
	var velocity = Vector2(enemy.speed, 0.0)
	enemy.linear_velocity = velocity.rotated(diretion)


func _on_bomb_timer_timeout():
	var screen_size = get_viewport().size
	var x = int(screen_size.x)
	var y = int(screen_size.y)
	
	var bomb = bomb_scene.instantiate()
	add_child(bomb)

	bomb.position = Vector2(randi() % x, randi() % y)
	


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
	
	var screen_size = get_viewport().size
	var x = screen_size.x
	var y = screen_size.y
	
	if(score % 3 == 0):
		var power_up = power_up_scene.instantiate()
		add_child(power_up)
 
		power_up.position = Vector2(randi() % x, randi() % y)


func _on_start_timer_timeout():
	$EnemyTimer.start()
	$ScoreTimer.start()
	$BombTimer.start()


func _on_hud_start_game():
	new_game()


func _on_player_bomb():
	$BombAudio.play()


func _on_player_power_up():
	$PowerUpAudio.play()

