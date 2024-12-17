extends Label

signal morreu
var dano = 3

func _on_player_dano():
	dano -= 1
	text=str(dano)
	
	if dano <= 0:
		emit_signal("morreu")
		
