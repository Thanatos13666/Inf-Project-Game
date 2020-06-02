extends Node2D


const rotation_speed = 2
var r = 90





func _ready():
	pass



func _process(delta):
	Input_key()
	

func Input_key():


	if Input.is_action_pressed("ui_a"):

		r -= rotation_speed;

		if r == 0:
			r = 360;
			set_rotation_degrees(r);

		if r < 0:
			r *= -1;
			set_rotation_degrees(r);

		if r > 0 && r <= 360:
			set_rotation_degrees(r);


	if Input.is_action_pressed("ui_d"):

		r += rotation_speed;

		if r < 360:
			set_rotation_degrees(r);

		if r == 360:
			r = 0;
			set_rotation_degrees(r);

		if r > 360:
			while r > 360:
				r = r - 360;
			set_rotation_degrees(r);





