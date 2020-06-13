extends Node
var player1 =false
var sp1
var sp2
var select_possible =true
signal sp1_dran
signal sp2_dran
#prelod all maps 
#ist langsam aber einfach

#var Map = preload("")
#var Map_list=[Map]



signal updateborders #dammit bestimmter code nach dieser -r

func _ready():
	sp1 =get_node("Spieler/SP1/CL/Control/GUI")
	sp2 = get_node("Spieler/SP2/CL/Control/GUI")
	var sp1_info = sp1.get_node("VBoxContainer2/top bar/top_groop/v align/h align/icon container/HBoxContainer")
	var sp2_info = sp2.get_node("VBoxContainer2/top bar/top_groop/v align/h align/icon container/HBoxContainer")
	connect("sp1_dran",sp1,"jetzt_dran")
	connect("sp2_dran",sp2,"jetzt_dran")
	
	
	next_player()#spieler 1 begint + spieler 2 verstecken
	
	#Map auswählen
	#dieser code fukioniert sher gut aber es ist nicht benötig einen so generellen fall zu machen vieleicht loht es sich später daher bitte hier lassen 
#	var file_name
#	var path ="res://game/maps/"
#	global.Map +=".tscn"
#	var dir = Directory.new()
#	if dir.open(path) == OK:
#		dir.list_dir_begin()
#		file_name = dir.get_next()
#		while file_name != "":
#			if !dir.current_is_dir():
#				if file_name==global.Map: #ausgewählte map im dateisystem gefunden 
#					break
#			file_name = dir.get_next()
#	else:
#		print("An error occurred when trying to access the path.")
#		get_tree().quit()
#	var Mappath = path+file_name
					
	var Mappath = "res://game/maps/"+ global.Map + ".tscn"
	var ladekarte = load(Mappath)
	var test = ladekarte.instance()
	get_node("MAP").add_child(test)
	
	connect("updateborders",sp1,"r_updateborders")
	connect("updateborders",sp2,"r_updateborders")
	emit_signal("updateborders")
	
	
	
	#get map
	#get gammode
	#get playernames

	sp1_info.get_child(0).text = global.sp1Name
	sp2_info.get_child(0).text = global.sp2Name

	
	pass
	
func recive_data():#ich habe vergesen zu was das gehört 
	print("recived")
	
func next_player():
	
	player1 = !player1
	if (player1):
		get_node("Spieler/SP1/CL/Control").visible = true
		get_node("Spieler/SP1/Camera2D").current = true
		get_node("Spieler/SP2/CL/Control").visible = false
		emit_signal("sp1_dran")
	else :
		get_node("Spieler/SP2/CL/Control").visible = true
		get_node("Spieler/SP2/Camera2D").current = true
		get_node("Spieler/SP1/CL/Control").visible = false
		emit_signal("sp2_dran")

	
	
	
	
	
