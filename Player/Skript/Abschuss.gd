extends Node2D

var schuss = preload("res://Player/Schuss.tscn")
var schuss_objekt
var timer = true



func _ready():
	pass 


func _process(delta):

	if Input.is_action_just_pressed("ui_limaus") and timer == true:
		timer = false 
		$Timer.start()
		schuss_objekt = schuss.instance()
		schuss_objekt.position = (get_global_position())
		schuss_objekt.rotate((PI/180)*(get_parent().r+27))
		get_tree().get_root().add_child(schuss_objekt)
		$Node2D/Sprite/AnimationPlayer.play("Abschuss")



func _on_Timer_timeout():
	timer = true
