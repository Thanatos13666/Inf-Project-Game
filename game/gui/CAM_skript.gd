extends Control


var speed =40
var zoom_speed = 0.07
var zoom_s = 1
var change = Vector2(0,0)
var px_hoehe =0
var px_breite =0


#limits setzen
func _ready():
	px_hoehe = 6400
	px_breite =6400
	if get_tree().get_root().has_node("MAP"):
		px_hoehe = (get_parent().get_parent().hoehe*64)+32 # wenn hier ein fheler ist: die camara darf nicht dierekt getartet werden sondern muss immer über eine map gestartet werden
		px_breite = (get_parent().get_parent().breite*64)+32

func _process(delta):
	change = Vector2(0,0)

#inputs apfragen
	if Input.is_action_pressed("CAM_zoom_in"):
		zoom_s += zoom_speed

	if Input.is_action_pressed("CAM_zoom_out"):
		zoom_s -= zoom_speed

	if Input.is_action_pressed("CAM_down"):
		change.y += speed*zoom_s

	if Input.is_action_pressed("CAM_up"):
		change.y -= speed*zoom_s

	if Input.is_action_pressed("CAM_left"):
		change.x -= speed*zoom_s

	if Input.is_action_pressed("CAM_right"):
		change.x += speed*zoom_s




	#limits abfragen

			# zoom_s limit
	if (zoom_s<0.5):
		zoom_s = 0.5
	if (zoom_s > 5):
		zoom_s = 5

#	if (1280*zoom_s > px_breite):
#		zoom_s = ((px_breite-(64*3))/1280)
#	if ( 720*zoom_s > px_hoehe):
#		zoom_s = ((px_hoehe-(64*3))/720)
#
		# move limit


	#limit right
#
#	if ((position.x + change.x)>px_breite-(zoom_s*(1280/2))):
#		change.x = px_breite-(zoom_s*1280/2)-position.x
#	#limit left
#	if ((position.x + change.x)<zoom_s*1280/2):
#		change.x = position.x-(zoom_s*1280/2)
#	#limit unten
#	if ((position.y + change.y)>px_hoehe-(zoom_s*(720/2))):
#		change.y = px_hoehe-(zoom_s*720/2)-position.y
#	#limit oben
#	if ((position.y + change.y)<zoom_s*720/2):
#		change.y = position.y-(zoom_s*720/2)


	#print(str(position.y) +" + "+str(change.y)+ " > "+ str(zoom_s))

#	if (abs(change.x)>200):
#		change.x = 0
#	if (abs(change.y)>200):
#		change.y = 0


	#berechnen
	if (rect_scale.x != zoom_s):
		rect_scale.x = zoom_s
		rect_scale.y = zoom_s
		$Camera2D.zoom.x =zoom_s
		$Camera2D.zoom.y =zoom_s
		#zoom.x = zoom_s
		#zoom.y = zoom_s
		#get_parent().get_node("GUI").rect_scale.x += zoom_s
		#get_parent().get_node("GUI").rect_scale.y += zoom_s

	rect_position.x += change.x
	rect_position.y += change.y
	$Camera2D.align()
	#get_parent().get_node("GUI").rect_position.x += change.x
	#get_parent().get_node("GUI").rect_position.y += change.y

	#align()
	pass
