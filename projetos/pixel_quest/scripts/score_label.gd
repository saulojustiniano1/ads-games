extends Label

signal ganhou
var moeda = 0

func _on_coin_coletor_moeda():
	moeda += 1
	text=str(moeda)
	
	if moeda == 10:
		emit_signal("ganhou")	
