extends Node

var laden = false
var file_name
#aktuelles spiel
var cur_game = "null"
var Map = "NEIN"

#spieler 1
var sp1Name = "Name1"
#spieler 2
var sp2Name = "Name2"





func save(save_res):
	var save_me = {
		"cur_game":cur_game,
		"Map":Map,
		"sp1Name" : sp1Name,
		"sp2Name" : sp2Name
	}
	
	save_res.data["global"]=save_me
	
func laden(save_res):
	var get_data =save_res.data["global"]
	cur_game = get_data.cur_game
	Map = get_data.Map
	sp1Name = get_data.sp1Name
	sp2Name = get_data.sp2Name
	
