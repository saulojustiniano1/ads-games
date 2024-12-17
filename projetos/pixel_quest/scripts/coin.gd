extends Area2D

signal coletor_moeda

@onready var audio_pegar_moeda = $"../../AudioPegarMoeda"

func _on_body_entered(body):
	$Sprite.hide()
	$Collision.set_deferred("disabled", true)
	audio_pegar_moeda.play()
	emit_signal("coletor_moeda")
	
	
