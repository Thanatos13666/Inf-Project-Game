extends Node



var subdata={}

func save(save_res):
	for child in get_children():
		child.save(self)
	
	save_res.data[get_path()]= subdata
	
func laden(save_res):
	for child in get_children():
		child.free()
	
	subdata = save_res.data[get_path()]
	for i in subdata :
		var child = load("res://units/unter_units/"+subdata[i].Typ+".tscn")
		var  add= child.instance()
		add_child(add)
		add.laden(subdata[i])