extends Node

@export var enemy_scene: PackedScene
var score

func new_game():
	score = 0
	get_tree().call_group('enemy', 'queue_free')
	$HUD.update_score(score)
	$HUD.show_message('Get Ready!')
	$Player.start($StartPosition.position)
	$MusicAudio.play()
	$StartTimer.start()

func game_over():
	$ScoreTimer.stop()
	$EnemyTimer.stop()
	$HUD.show_game_over()
	$MusicAudio.stop()
	$DeathAudio.play()

func _on_enemy_timer_timeout():
	# Cria uma nova instancia do enemy
	var enemy = enemy_scene.instantiate()
	# Obtem referencia ao node PathFllow2D
	var enemy_spawn_position = $EnemyPath/EnemySpawnPosition
	# Gere um valor entre 0.0 e 1.0 e atribui ao progress_ratio
	enemy_spawn_position.progress_ratio = randf()
	# Ajuste da rotacao adicionando 90 graus
	var diretion = enemy_spawn_position.rotation + PI / 2
	diretion += randf_range(-PI / 4, PI / 2)
	# Atribui posicao ao inimigo
	enemy.position = enemy_spawn_position.position
	# Atribui rotacao ao inimigo
	enemy.rotation = diretion
	# Difine a velocidade de movimento ao inimigo
	var velocity = Vector2(randf_range(100.0, 250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(diretion)
	# adicionaa a instancia na scena main
	add_child(enemy)

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	$EnemyTimer.start()
	$ScoreTimer.start()

func _on_hud_start_game():
	new_game()
