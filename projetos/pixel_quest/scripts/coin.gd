extends Area2D

var audio_coletar
var timer

func _ready():
	# Chama a função para posicionar a moeda aleatoriamente
	randomize_coin_position()

func _on_body_entered(body):
	if body.is_in_group("player"):
		play_collect_sound()
		start_timer()

func randomize_coin_position():
	# Obtém o tamanho da viewport visível
	var viewport_size = get_viewport().size
	var camera = get_viewport().get_camera_2d()  # Obtém a Camera2D

	if camera:
		# Define o centro da câmera
		var cam_position = camera.global_position
		var cam_size = Vector2(viewport_size) / camera.zoom  # Conversão explícita para Vector2

		# Calcula os limites de spawn da moeda
		var x_min = cam_position.x - (cam_size.x / 2)
		var x_max = cam_position.x + (cam_size.x / 2)
		var y_min = cam_position.y - (cam_size.y / 2)
		var y_max = cam_position.y + (cam_size.y / 2)

		# Posiciona a moeda em um ponto aleatório dentro dos limites
		position.x = randf_range(x_min, x_max)
		position.y = randf_range(y_min, y_max)

func play_collect_sound():
	audio_coletar = AudioStreamPlayer.new()
	add_child(audio_coletar)
	audio_coletar.stream = preload("res://songs/pegar_moeda.mp3")
	audio_coletar.volume_db = -30
	audio_coletar.play()

func start_timer():
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = audio_coletar.stream.get_length()
	add_child(timer)
	timer.start()

func _process(delta):
	if timer and not timer.is_stopped():
		return

	if timer:
		timer.queue_free()
		queue_free()
