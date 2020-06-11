extends Node2D

signal is_selected(selber)

#base functions-----------------------------------------------------------------
func die():
	self.queue_free();
	pass

func move():
	
	pass

#testvariable-------------------------------------------------------------------
var select_possible = false
#-------------------------------------------------------------------------------

func _on_Button_pressed():
	if select_possible:
		emit_signal("is_selected",self)
		print("select possible")
	else:
		print("select")
	pass

var has_attacked = false;
