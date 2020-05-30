extends Control


var speed =40
var zoom_speed = 0.07
var zoom_s = 1
var change = Vector2(0,0)
var futur_pos = Vector2(0,0)
var px_hoehe =0
var px_breite =0


#limits setzen
func _ready():
	get_tree().get_root().connect("size_changed", self, "update_ofset")
	px_hoehe = 6400.0
	px_breite =6400.0
	if get_tree().get_root().has_node("MAP"):
		px_hoehe = (get_parent().get_parent().hoehe*64) # wenn hier ein fheler ist: die camara darf nicht dierekt getartet werden sondern muss immer über eine map gestartet werden
		px_breite = (get_parent().get_parent().breite*64)

func _process(delta):
	change = Vector2(0,0)

#inputs apfragen



	if Input.is_action_just_released("CAM_zoom_in_wheel"):
		zoom_s += zoom_speed

	if Input.is_action_just_released("CAM_zoom_out_wheel"):
		zoom_s -= zoom_speed
		
	if Input.is_action_pressed("CAM_zoom_in"):
		zoom_s += zoom_speed/2

	if Input.is_action_pressed("CAM_zoom_out"):
		zoom_s -= zoom_speed/2

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
		#fix limit
	if (zoom_s<0.5):
		zoom_s = 0.5
	if (zoom_s > 7):
		zoom_s = 7
	# dynamic limit
	var lim_y =((px_breite)/get_viewport_rect().size.y)
	var lim_x =((px_breite)/get_viewport_rect().size.x)
	if (lim_y<zoom_s):
		zoom_s= lim_y
	if (lim_x<zoom_s):
		zoom_s= lim_x
		

	# move limit
	#calculate futur position
	var _p  = get_parent().rect_position  # _p als verkürtzung
	futur_pos.x = _p.x + change.x
	futur_pos.y = _p.y + change.y
	
	#berechne limit (fürs einache ändern)
	var lim_top = 0 
	var lim_lef = 0
	var lim_low = px_breite -(get_viewport_rect().size.y*zoom_s)
	var lim_rit = px_hoehe  -(get_viewport_rect().size.x*zoom_s)
	

	#print(get_node("Camera2D").position)
	#check ob wir außerhalb sein werden 
	if(lim_top>futur_pos.y):
		change.y=0-_p.y  
	if(lim_lef>futur_pos.x):
		change.x=0-_p.x  
	if(lim_low<futur_pos.y):
		change.y=lim_low -_p.y  
	if(lim_rit<futur_pos.x):
		change.x=lim_rit-_p.x  
	#print(change)
	
	
	#limit right
	
	
	

	#print(str(position.y) +" + "+str(change.y)+ " > "+ str(zoom_s))

#	if (abs(change.x)>200):
#		change.x = 0
#	if (abs(change.y)>200):
#		change.y = 0


	#berechnen
	if (get_parent().rect_scale.x != zoom_s):
		get_parent().rect_scale.x = zoom_s
		get_parent().rect_scale.y = zoom_s
		$Camera2D.zoom.x =zoom_s
		$Camera2D.zoom.y =zoom_s
	
	get_parent().rect_position.x += change.x
	get_parent().rect_position.y += change.y
	$Camera2D.align()
	pass


func update_ofset():
	get_node("Camera2D").position.y=780 /2 - (780  -get_viewport_rect().size.y)/2
	get_node("Camera2D").position.x=1280/2 - (1280 -get_viewport_rect().size.x)/2
	