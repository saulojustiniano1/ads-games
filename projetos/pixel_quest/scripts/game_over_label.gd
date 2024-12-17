extends Label

@onready var game_over_label = $"."
@onready var audio_game_over = $"../../AudioGameOver"

func _ready():
	hide()

func _on_life_label_morreu():
	game_over_label.visible = true
	audio_game_over.play()
