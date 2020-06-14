extends Node2D

var schuss = preload("res://units/Schuss.tscn")
var schuss_objekt
onready var ParentNode2D = get_parent().get_parent().get_parent()

func _ready():
	pass 


func _process(delta):

	if Input.is_action_just_pressed("ui_limaus") and ParentNode2D.button_attack == true:
		var offset = -PI * 0.5
		var Waffe_pos = get_parent().get_node("Waffe").position
		var mouse_pos = get_viewport().get_mouse_position()
		var angle = Waffe_pos.angle_to_point(mouse_pos)
		get_parent().get_node("Waffe").rotation = -angle + offset
		
		schuss_objekt = schuss.instance()
		schuss_objekt.position = (get_global_position())
		schuss_objekt.rotate((PI/180)*(get_parent().rotation_degrees))
		schuss_objekt.set_schaden(get_parent().get_parent().get_parent().curr_values.Angriff)
		get_tree().get_root().add_child(schuss_objekt)
		ParentNode2D.button_attack = false
		#$Node2D/Sprite/AnimationPlayer.play("Abschuss")
