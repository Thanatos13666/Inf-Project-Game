extends Button
var show= false

func _on_Button_toggled(button_pressed):
	
	show = !show
	if (show):
		get_parent().get_node("u_r/ScrollContainer").visible= true
	else : 
		get_parent().get_node("u_r/ScrollContainer").visible= false
