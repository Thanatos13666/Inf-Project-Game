extends Control
var cam
#camera varieabeln
var speed =40
var zoom_speed = 0.07
var zoom_s = 1
var change = Vector2(0,0)
var futur_pos = Vector2(0,0)
var px_hoehe =0
var px_breite =0
#spieler varieabeln
var geld=100
var geld_anderung=10

#reddy
func _ready():
	cam = get_parent().get_parent().get_parent().get_node("Camera2D")
	#cam
	get_tree().get_root().connect("size_changed", self, "update_ofset")
	px_hoehe = 6400.0
	px_breite =6400.0
	#spieler
	
	
	




func _process(delta):
	change = Vector2(0,0)

#inputs apfragen
	if get_parent().visible==true:
		cam_activ()

#camera skripts --------------------------------------------------------------------------------------------------------------------------------------
func cam_activ():
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
	var _p  = cam.position  # _p als verkürtzung
	futur_pos.x = _p.x + change.x
	futur_pos.y = _p.y + change.y
	
	#berechne limit (fürs einache ändern)
	var lim_top = (get_viewport_rect().size.y*zoom_s)/2
	var lim_lef = (get_viewport_rect().size.x*zoom_s)/2
	var lim_low = px_breite -(get_viewport_rect().size.y*zoom_s)/2
	var lim_rit = px_hoehe  -(get_viewport_rect().size.x*zoom_s)/2
	

	
	#check ob wir außerhalb sein werden 
	if(lim_top>futur_pos.y):
		change.y=lim_top-_p.y  
	if(lim_lef>futur_pos.x):
		change.x=lim_lef-_p.x  
	if(lim_low<futur_pos.y):
		change.y=lim_low -_p.y  
	if(lim_rit<futur_pos.x):
		change.x=lim_rit-_p.x  

	
	
	#limit right
	cam.limit_left=0
	cam.limit_right =64* owner.get_node("MAP").get_child(0).breite
	cam.limit_top=0
	cam.limit_bottom  =64* owner.get_node("MAP").get_child(0).hoehe
	
	cam.zoom.x =zoom_s
	cam.zoom.y =zoom_s
	
	cam.position.x += change.x
	cam.position.y += change.y
	
	cam.align()
	pass


func update_ofset():
	#cam.position.y=780 /2 - (780  -get_viewport_rect().size.y)/2
	#cam.position.x=1280/2 - (1280 -get_viewport_rect().size.x)/2
	pass
	
func r_updateborders():
	var mapdata =owner.get_node("MAP").get_child(0)
	px_hoehe = mapdata.hoehe*64
	px_breite = mapdata.breite*64


#spieler skripts --------------------------------------------------------------------------------------------------------------------------------------

func jetzt_dran(): #reagiert sobald ein spieler dran ist
	geld += geld_anderung
	cam = get_parent().get_parent().get_parent().get_node("Camera2D")