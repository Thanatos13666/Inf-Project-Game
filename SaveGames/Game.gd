extends Node
var player1 =false
#prelod all maps 
#ist langsam aber einfach

#var Map = preload("")
#var Map_list=[Map]



signal updateborders #dammit bestimmter code nach dieser -r

func _ready():
	print(self)
	var sp1 =get_node("Spieler/SP1/Control/GUI")
	var sp2 = get_node("Spieler/SP2/Control/GUI")
	var sp1_info = sp1.get_node("VBoxContainer2/top bar/top_groop/v align/h align/icon container/HBoxContainer")
	var sp2_info = sp2.get_node("VBoxContainer2/top bar/top_groop/v align/h align/icon container/HBoxContainer")
	
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
	var Map = load(Mappath)
	get_node("MAP").add_child(Map.instance())
	
	connect("updateborders",sp1,"r_updateborders")
	connect("updateborders",sp2,"r_updateborders")
	emit_signal("updateborders")
	print("game.self:")
	print(self)
	print(self.get_child(0))
	print(self.get_child(0).get_child(0))
	
	
	#get map
	#get gammode
	#get playernames

	sp1_info.get_child(0).text = global.sp1Name
	sp2_info.get_child(0).text = global.sp2Name

	
	pass
	
func recive_data():
	print("recived")
	
func next_player():
	print("wechsele spiler")
	player1 = !player1
	if (player1):
		get_node("Spieler/SP1/Control").visible = true
		get_node("Spieler/SP1/Control/GUI/Camera2D").current = true
		get_node("Spieler/SP2/Control").visible = false
	else :
		get_node("Spieler/SP2/Control").visible = true
		get_node("Spieler/SP2/Control/GUI/Camera2D").current = true
		get_node("Spieler/SP1/Control").visible = false
	
	
	
	
	
	
