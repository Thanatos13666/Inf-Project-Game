extends Control

export(int) var breite
export(int) var hoehe
export var spaw_sp1 : Vector2
export var spaw_sp2 : Vector2


func get_nav(var start, var ziel):
	return $Navigation2D.get_simple_path(start, ziel, true)
