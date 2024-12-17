extends Label

var moeda = 0

func _on_coin_coletor_moeda():
	moeda += 1
	text=str(moeda)
