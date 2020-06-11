extends Node2D

signal is_selected(selber)

#base functions-----------------------------------------------------------------
func die():
	self.queue_free();
	pass

func move():
	
	pass


func _on_Button_pressed():
	emit_signal("is_selected",self)
	pass
