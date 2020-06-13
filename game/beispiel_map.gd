extends Control

export(int) var breite
export(int) var hoehe



func get_nav(var start, var ziel):
	return $Navigation2D.get_simple_path(start, ziel, true)