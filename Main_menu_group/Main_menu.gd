extends Control
func _ready():
	for button in $MarginContainer/HBoxContainer/VBoxContainer/MC/Menue/centerrow/LeftCon/Buttons.get_children():
		button.connect("pressed",self,"_on_Button_pressed",[button.scene_to_load])


func _on_Button_pressed(scene_to_load):
	if (scene_to_load == "END"):
		get_tree().quit()
	get_tree().change_scene(scene_to_load)


