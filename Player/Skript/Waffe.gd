extends Node2D


const rotation_speed = 2
var r = 90
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	input_key()


func input_key():


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
