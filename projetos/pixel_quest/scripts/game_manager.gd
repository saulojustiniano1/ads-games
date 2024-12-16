extends Node

var player
var player_start_position
var background_audio
var game_over_audio
var pular_audio
var moedas = 0
var coin_timer
var tile_map
var coin_scene

func _ready():
	# Verificar se o player foi configurado corretamente.
	if player == null:
		print("Aguardando inicialização do Player...")
		# Aguardar até que o Player esteja configurado
		await get_tree().create_timer(0.1).timeout 
		
	# Agora o Player deve estar configurado
	if player != null:
		player_start_position = player.position
		print("Player e GameManager inicializados com sucesso!")
	else:
		print("Erro: Player não encontrado!")

	_inicializar_audio()
	_inicializar_timer()  # Chama a função para inicializar o timer

	# Inicializar o TileMap
	tile_map = get_node("TileMap")  # Ajuste o caminho para o seu TileMap, se necessário
	coin_scene = preload("res://scenes/coin.tscn")  # Carregar a cena da moeda uma vez

func _process(delta):
	if player:
		if Input.is_action_just_pressed("jump"):  # Certifique-se de que "jump" é a ação configurada
			player_jump()

func _inicializar_audio():
	# Inicializa o áudio de fundo
	background_audio = AudioStreamPlayer.new()
	add_child(background_audio)
	background_audio.stream = preload("res://songs/background.mp3")
	background_audio.volume_db = -20  # Ajuste o volume conforme necessário
	background_audio.play()

	# Inicializa o áudio de game over
	game_over_audio = AudioStreamPlayer.new()
	add_child(game_over_audio)
	game_over_audio.stream = preload("res://songs/game_over.mp3")
	game_over_audio.volume_db = -20  # Ajuste o volume conforme necessário

	# Inicializa o áudio de pular
	pular_audio = AudioStreamPlayer.new()
	add_child(pular_audio)
	pular_audio.stream = preload("res://songs/pular.mp3")
	pular_audio.volume_db = -20  # Ajuste o volume conforme necessário

func _inicializar_timer():
	# Verifica se o coin_timer já existe
	if coin_timer == null:
		print("Erro: Timer não encontrado!")
		return
	
	# Diminui o intervalo para 2 segundos (ajuste conforme necessário)
	coin_timer.wait_time = 2.0
	# Conecta o sinal timeout do timer à função que gera a moeda
	coin_timer.connect("timeout", Callable(self, "_gerar_moeda"))
	coin_timer.start()  # Inicia o timer

func _gerar_moeda():
	# Lógica para gerar uma moeda no cenário
	if player:
		var coin_instance = coin_scene.instance()  # Cria a moeda

		# Tentar gerar a moeda até encontrar uma posição livre
		var coin_position = _gerar_posicao_random()
		while verificar_colisao_com_tilemap(coin_position):
			coin_position = _gerar_posicao_random()
		
		# Posiciona a moeda na posição válida
		coin_instance.position = coin_position
		get_tree().current_scene.add_child(coin_instance)

func _gerar_posicao_random():
	# Define os limites do cenário com base na câmera
	var camera = get_node("Camera2D")  # Ajuste o caminho para o nó da sua câmera, se necessário
	var camera_rect = camera.get_camera_screen_rect()  # Retorna o retângulo de visão da câmera
	var random_pos = Vector2(
		randf_range(camera_rect.position.x, camera_rect.position.x + camera_rect.size.x),
		randf_range(camera_rect.position.y, camera_rect.position.y + camera_rect.size.y)
	)
	return random_pos

func verificar_colisao_com_tilemap(coin_position):
	# Verifica se há um tile no local da moeda
	var tile_pos = tile_map.world_to_map(coin_position)  # Converte a posição mundial para a posição do TileMap
	var tile_id = tile_map.get_cellv(tile_pos)  # Obtém o ID do tile na posição

	# Se o tile_id não for -1, significa que há um tile no local da moeda
	return tile_id != -1  # Retorna true se a posição estiver ocupada por um tile, e false caso contrário

func player_entered_reset_area():
	# Reproduz o áudio de game over
	game_over_audio.play()
	player.position = player_start_position

func player_jump():
	print("Pulo detectado! Reproduzindo som.")
	# Reproduz o áudio de pular
	pular_audio.play()
