extends KinematicBody2D



export (int) var speed = 200
var leben = 3
var schaden = 2

var target = Vector2()
var velocity = Vector2()

func _physics_process(delta):

	rotation = velocity.angle()
	velocity = (target - position).normalized() * speed
	if (target - position).length() > 5:
		move_and_slide(velocity)
	check_leben()




func _input(event):
	if event.is_action_pressed('ui_remaus'):
		target = get_global_mouse_position()


func treffer():

	leben = leben - 1

func get_schaden():
	return schaden

func check_leben():

	if leben <= 0:
		queue_free()