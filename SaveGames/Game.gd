extends Node
var player1 =false


var select_possible =true
signal sp1_dran
signal sp2_dran
#prelod all maps 
#ist langsam aber einfach

#var Map = preload("")
#var Map_list=[Map]
#links
var sp1
var sp2

func _input(event):
	if event.is_action_pressed('new_round'):
		next_player()

signal updateborders #dammit bestimmter code nach dieser -r

func _ready():
	sp1 =get_node("Spieler/SP1/CL/Control/GUI")
	sp2 = get_node("Spieler/SP2/CL/Control/GUI")
	connect("sp1_dran",sp1,"jetzt_dran")
	connect("sp2_dran",sp2,"jetzt_dran")
	
	#spieler 1 begint + spieler 2 verstecken
	
	
	if (!global.laden):#std ist false 
		next_player()
		set_map()
		sp1.cam.position = $MAP.get_child(0).spaw_sp1
		sp2.cam.position = $MAP.get_child(0).spaw_sp2
	else:
		speichern.laden(global.filename)
	sp1.sp_info.get_node("Label").text=global.sp1Name
	sp2.sp_info.get_node("Label").text=global.sp2Name
	sp1.spawnpoint = $MAP.get_child(0).spaw_sp1
	sp2.spawnpoint = $MAP.get_child(0).spaw_sp2
	sp1.spieler_str = "SP1"
	sp2.spieler_str = "SP2"
	sp1.shop.lade_shop()
	sp2.shop.lade_shop()
	
func recive_data():#ich habe vergesen zu was das gehört 
	print("recived")
	
func next_player():
	
	player1 = !player1
	if (player1):
		get_node("Spieler/SP1/CL/Control").visible = true
		get_node("Spieler/SP1/Camera2D").current = true
		get_node("Spieler/SP2/CL/Control").visible = false
		emit_signal("sp1_dran")
		for unit in $units_in_game/SP1.get_children():
			unit.button_move = 0
			unit.button_attack = 0;
		#durch alle einheiten gehen und bereit auf true setztn

	else :
		get_node("Spieler/SP2/CL/Control").visible = true
		get_node("Spieler/SP2/Camera2D").current = true
		get_node("Spieler/SP1/CL/Control").visible = false
		emit_signal("sp2_dran")
		for unit in $units_in_game/SP2.get_children():
			unit.button_move = 0
			unit.button_attack = 0;
		#durch alle einheiten gehen und bereit auf true setztn

func save(save_res):
	save_res.data[get_path()] = player1
	pass

func laden(save_res):
	player1 = save_res.data[get_path()]
	player1 = !player1
	next_player()
	set_map()
	
	
func set_map():
	var Mappath = "res://game/maps/"+ global.Map + ".tscn"
	var ladekarte = load(Mappath)
	get_node("MAP").add_child(ladekarte.instance())
	connect("updateborders",sp1,"r_updateborders")
	connect("updateborders",sp2,"r_updateborders")
	emit_signal("updateborders")

	
	
