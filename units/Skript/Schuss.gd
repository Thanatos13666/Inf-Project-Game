extends Area2D

var speed = 300


func _ready():
	pass # Replace with function body.

func _process(delta):
	translate(transform.y * -speed * delta)

func _on_Timer_timeout():
	queue_free()

