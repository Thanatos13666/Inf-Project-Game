extends Node2D
var gamenode # wird besetzt sobbals obj erzeugt wird
var can_attack = true;

# Variablen für move()
var velocity = Vector2()
var target = Vector2()
var target_attack = Vector2()
var button_move = 0
var button_attack = 0;
var schuss = preload("res://units/Schuss.tscn")
var schuss_objekt

var test_count =0

var old_pos
#var start = position
#var ziel
#var bewegung = Vector2()
#var path = PoolVector2Array()
#var node = load("res://game/maps/beispiel_map.tscn").instance()
#-------------------------------------------------------------------------------
signal is_selected(selber)

#variables----------------------------------------------------------------------
var base_values = {
	"Preis":120,
	"Leben":10,
	"Angriff":5,
	"Ausweichen":10,
	"Reichweite": 700,
	"Bewegungsrate":400
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
	"Angriff":base_values.Angriff,
	"Ausweichen":base_values.Ausweichen,
	"Reichweite":base_values.Reichweite,
	"Bewegungsrate":base_values.Bewegungsrate,
}

var func_list = {
	"reset_values":funcref(self,"reset_values"),
	"Angriff":funcref(self,"Angriff"),
	"Bewegen":funcref(self,"Bewegen")
}


func _physics_process(delta):
	move()

func _process(delta):
	attack();

#test funktionen

func Angriff():
	if button_attack == 0:
		button_attack = 1
	if button_move == 1:
		button_move = 0

func Bewegen():
	if button_move == 0:
		button_move = 1
	if button_attack == 1:
		button_attack = 0
	


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
	"button_attack":false
}

func save(save_res):
	save_me.pos = position
	save_me.Leben = curr_values.Leben
	save_me.Angriff = curr_values.Angriff
	save_me.Ausweichen = curr_values.Ausweichen
	save_me.Reichweite = curr_values.Reichweite
	save_me.Bewegungsrate = curr_values.Bewegungsrate
	save_me.button_attack=button_attack

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
	button_attack = values.button_attack


#base functions-----------------------------------------------------------------
func reset_values():
	curr_values=base_values #es muss überprüft werdenob das geht

func die():
	self.queue_free();
	pass

func move():
	if gamenode == null:
		return

#-------------------------------------------------------------------------------------------------------
# move() mit Pathfinding
# node.get_nav(start, ziel) bzw. get_simple_path() gibt nichts zurück
# --------------------------------------------------------------------
#
#	if Input.is_action_pressed('ui_remaus'):
#		ziel = get_global_mouse_position()
#
#	if ziel == null:
#		return
#
#	path = node.get_nav(start, ziel)
#
#	for i in range(path.size()):
#		var sub_ziel = start.distance_to(path[0])
#		if distance <= sub_ziel and distance >= 0:
#			$pre_unit.look_at(path[0])
#			$pre_unit.move_and_slide((path[0] - $pre_unit.get_global_position()).normalized() * (curr_values.Bewegungsrate*25))
#			break
#		elif distance < 0:
#			$pre_unit.get_global_position() = path[0]
#			break
#		distance -= sub_ziel
#		start = path[0]
#		path.remove(0)
#
#-------------------------------------------------------------------------------------------------------

# move() ohne Pathfinding

	if Input.is_action_pressed('ui_remaus') && button_move == 1:
		target = get_global_mouse_position()
		old_pos = $pre_unit.position
		button_move = 2
	if target == Vector2(0,0):
		return

	velocity = (target - $pre_unit.get_global_position()).normalized() * (200)
	$pre_unit.rotation = velocity.angle()

	if (target - $pre_unit.get_global_position()).length() > 5 and old_pos.distance_to($pre_unit.position)<curr_values.Bewegungsrate:
		$pre_unit.move_and_slide(velocity)


func attack():
	if Input.is_action_just_pressed("ui_limaus") and button_attack == 1:
		target_attack = get_global_mouse_position();
		get_node("pre_unit/Waffe").look_at(target_attack)
		get_node("pre_unit/Waffe").rotation += 1.5708
		
		schuss_objekt = schuss.instance()
		schuss_objekt.position = (get_node("pre_unit/Waffe/Abschuss").get_global_position())
		schuss_objekt.rotate((PI/180)*(get_node("pre_unit/Waffe").rotation_degrees+get_node("pre_unit").rotation_degrees+90))
		schuss_objekt.set_schaden(curr_values.Angriff)
		schuss_objekt.from_unit=self
		gamenode.add_child(schuss_objekt)
		button_attack = 2;
	pass

func _on_Button_pressed():#Button ist hier die figur je selbst
	owner = get_parent().get_parent().get_parent()

	if gamenode.select_possible:
		emit_signal("is_selected",self)
	pass

func getDmg(dmg):
	curr_values.Leben -= dmg;
	if curr_values.Leben <= 0:
		die();
	pass
