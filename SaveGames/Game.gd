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


signal updateborders #dammit bestimmter code nach dieser -r

func _ready():
	sp1 =get_node("Spieler/SP1/CL/Control/GUI")
	sp2 = get_node("Spieler/SP2/CL/Control/GUI")
	connect("sp1_dran",sp1,"jetzt_dran")
	connect("sp2_dran",sp2,"jetzt_dran")
	
	next_player()#spieler 1 begint + spieler 2 verstecken
	
	
	if (!global.laden):#std ist false 
		set_map()
	else:
		speichern.laden(global.filename)


	
func recive_data():#ich habe vergesen zu was das gehört 
	print("recived")
	
func next_player():
	
	player1 = !player1
	if (player1):
		get_node("Spieler/SP1/CL/Control").visible = true
		get_node("Spieler/SP1/Camera2D").current = true
		get_node("Spieler/SP2/CL/Control").visible = false
		emit_signal("sp1_dran")
		#durch alle einheiten gehen und bereit auf true setztn
	else :
		get_node("Spieler/SP2/CL/Control").visible = true
		get_node("Spieler/SP2/Camera2D").current = true
		get_node("Spieler/SP1/CL/Control").visible = false
		emit_signal("sp2_dran")
		#durch alle einheiten gehen und bereit auf true setztn

func save(save_res):
	save_res.data[get_path()] = player1
	pass

func laden(save_res):
	player1 = save_res.data[get_path()]
	set_map()
	
	
func set_map():
	print(global.Map)
	var Mappath = "res://game/maps/"+ global.Map + ".tscn"
	var ladekarte = load(Mappath)
	get_node("MAP").add_child(ladekarte.instance())
	connect("updateborders",sp1,"r_updateborders")
	connect("updateborders",sp2,"r_updateborders")
	emit_signal("updateborders")

	
	
