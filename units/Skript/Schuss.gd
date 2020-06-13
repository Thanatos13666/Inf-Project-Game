extends Area2D

var speed = 300
var schaden
var i = 0
onready var area = $Area2D


func _ready():
	pass # Replace with function body.

func _process(delta):
	translate(transform.y * -speed * delta)
	check_tank()

func _on_Timer_timeout():
	queue_free()


func check_tank():

	for body in area.get_overlapping_bodies():
		if body.has_method("get_dmg") and body.leben > 0:
				body.get_dmg(schaden)
				i = i + 1
				$Sprite/AnimationPlayer.play("Explosion")
				queue_free()


func set_schaden(var sch):

	schaden = sch
