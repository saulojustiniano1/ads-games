extends Node

var player
var player_start_position

func player_entered_reset_area():
	player.position = player_start_position
