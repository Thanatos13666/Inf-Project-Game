extends Node2D
var gamenode # wird besetzt sobbals obj erzeugt wird
var can_attack = true;

signal is_selected(selber)

#variables----------------------------------------------------------------------
var base_values = {
	"Preis":120,
	"Leben":10,
	"Angriff":1,
	"Ausweichen":10,
	"Reichweite": 7,
	"Bewegungsrate":8
}

#######################################################################################

# Nutze dieses als code preset in jedem 
# Einfach Copypaste und dann die 
# func _ready eingefügten zeilen auswählen und
# Strg + k zum mehrzeiliegen auskomentieren
	
#	base_values.Preis=
#	base_values.Leben = 
#	base_values.Angriff=
#	base_values.Ausweichen=
#	base_values.Reichweite=
#	base_values.Bewegungsrate=
#	reset_values()
	
#######################################################################################
var curr_values = {
	"Leben":base_values.Leben,
	"Angriff":0,
	"Ausweichen":base_values.Ausweichen,
	"Reichweite":base_values.Reichweite,
	"Bewegungsrate":base_values.Bewegungsrate,
}

var func_list = {
	"reset_values":funcref(self,"reset_values"),
	"test_A":funcref(self,"test_A"),
	"test_B":funcref(self,"test_B"),
	"getDmg":funcref(self,"getDmg")
}

#test funktionen
func test_A():
	print("test_A")
func test_B():
	print("test_B")

#Speichern und Laden------------------------------------------------------------

#varieabeln die abgespeichert werden sollen
var save_me={#hier kommt rein was wirklich JEDE unterklsse hat
	"Typ":"pre_unit",		#muss in unterklassen überschrieben werden
	"pos":Vector2(0,0),
	"Leben":0,
	"Angriff":0,
	"Ausweichen":0,
	"Reichweite":0,
	"Bewegungsrate":0,
}

func save(save_res):
	save_me.pos = position
	save_me.Leben = curr_values.Leben
	save_me.Angriff = curr_values.Angriff
	save_me.Ausweichen = curr_values.Ausweichen
	save_me.Reichweite = curr_values.Reichweite
	save_me.Bewegungsrate = curr_values.Bewegungsrate
	
	speacial_save()
	
	save_res.subdata[get_index()]= save_me
	
func speacial_save(): #wird in den deinzelnen klassen ausdiferenziert
	pass
	
func laden(values):
	position = values.pos 
	curr_values.Leben = values.Leben
	curr_values.Angriff = values.Angriff
	curr_values.Ausweichen = values.Ausweichen
	curr_values.Reichweite = values.Reichweite
	curr_values.Bewegungsrate = values.Bewegungsrate
	
	
#base functions-----------------------------------------------------------------
func reset_values():
	curr_values=base_values #es muss überprüft werdenob das geht

func die():
	self.queue_free();
	pass

func move():
	
	pass

func attack():
	
	pass

func _on_Button_pressed():#Button ist hier die figur je selbst
	owner = get_parent().get_parent().get_parent()

	if gamenode.select_possible:
		emit_signal("is_selected",self)
		print("select possible")
	else:
		print("select")
	pass

func getDmg():
	var dmg=0
	print("std get dmg")
	curr_values.Leben -= dmg;
	if curr_values.Leben <= 0:
		die();
	pass