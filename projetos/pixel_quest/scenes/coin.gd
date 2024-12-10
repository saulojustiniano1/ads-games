extends Area2D

var coletar_audio
var timer

func _on_body_entered(body):
	if body.is_in_group("player"):
		coletar_audio = AudioStreamPlayer.new()
		add_child(coletar_audio)
		coletar_audio.stream = preload("res://songs/pegar_moeda.mp3")
		coletar_audio.volume_db = -30  # Ajusta o volume
		coletar_audio.play()  # Toca o som

		# Cria um Timer para aguardar a duração do som
		timer = Timer.new()
		timer.one_shot = true
		timer.wait_time = coletar_audio.stream.get_length()  # Obtém a duração do som
		add_child(timer)
		timer.start()

func _process(delta):
	# Verifica se o timer terminou
	if timer and not timer.is_stopped():
		return

	if timer:
		timer.queue_free()
		queue_free()
