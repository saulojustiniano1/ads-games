extends Label

@onready var win_label = $"."
@onready var audio_vitoria = $"../../AudioVitoria"

func _ready():
	hide()

func _on_score_label_ganhou():
	win_label.visible = true
	audio_vitoria.play()
	GameManager.player_entered_reset_area()
