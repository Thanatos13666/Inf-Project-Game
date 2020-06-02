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
		schuss_objekt.transform = transform
		get_parent().add_child(schuss_objekt)
		$Sprite/AnimationPlayer.play("Abschuss")


func _on_Timer_timeout():
	timer = true
