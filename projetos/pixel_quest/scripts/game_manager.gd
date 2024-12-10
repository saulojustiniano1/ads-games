extends Node

var player
var player_start_position
var background_audio
var game_over_audio
var pular_audio
var moedas = 0

func _ready():
	_inicializar_audio()


func _process(delta):
	if Input.is_action_just_pressed("jump"):
		player_jump()


func _inicializar_audio():
	background_audio = AudioStreamPlayer.new()
	add_child(background_audio)
	background_audio.stream = preload("res://songs/background.mp3")
	background_audio.play()
	background_audio.volume_db = -30

	game_over_audio = AudioStreamPlayer.new()
	add_child(game_over_audio)
	game_over_audio.stream = preload("res://songs/game_over.mp3")
	game_over_audio.volume_db = -20

	pular_audio = AudioStreamPlayer.new()
	add_child(pular_audio)
	pular_audio.stream = preload("res://songs/pular.mp3")
	pular_audio.volume_db = -40
	 

func player_entered_reset_area():
	game_over_audio.play()
	player.position = player_start_position


func player_jump():
	pular_audio.play()


