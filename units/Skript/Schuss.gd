extends Area2D

var from_unit
var speed = 500
var schaden
var i = 0
var dmg_taken = true
onready var area = $Area2D

func _process(delta):
	translate(transform.y * -speed * delta)
	check_tank()
	if get_global_position().distance_to(from_unit.get_node("pre_unit").get_global_position())>from_unit.curr_values.Reichweite:
		fertig()

func check_tank():
	for body in area.get_overlapping_bodies():
		if body.get_parent().has_method("getDmg"):
				i = i + 1
				if dmg_taken:
					body.get_parent().getDmg(schaden)
					dmg_taken = false
		fertig()

func fertig():
	$Sprite/AnimationPlayer.play("Explosion")
	yield($Sprite/AnimationPlayer, "animation_finished" )
	self.queue_free()

func set_schaden(var sch):

	schaden = sch
