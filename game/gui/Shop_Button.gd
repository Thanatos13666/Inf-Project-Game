extends Button



func _ready():
	_on_Button_toggled(true)
func _on_Button_toggled(button_pressed):
	#es gibt garantiert ne beserelösung als dieses hier
	get_parent().get_parent().get_parent().get_node("shop grop/HBoxContainer/VBoxContainer/u_r/Shop_scroll_con").visible = pressed #sichtbarkeit = bool buton gedrückt
