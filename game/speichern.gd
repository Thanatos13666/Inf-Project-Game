extends Node

var save_class = preload("res://game/speichern_class.gd")
var SAVER_FOLDER = "res://SaveGames/USER/"
var SAVE_NAME_TEP = "save_%03d.tres"
var data :Dictionary ={}


func save(filename):
	var save_res = save_class.new()
#	save_res.game_version = ProjectSettings.get_setting('application/config/version')
	global.save(save_res)
	for node in get_tree().get_nodes_in_group("speichern"):
		node.save(save_res)
	
	var dir = Directory.new()
	if not dir.dir_exists(SAVER_FOLDER):
		dir.make_dir_recursive(SAVER_FOLDER)
	
	var save_path = SAVER_FOLDER.plus_file(filename)
	var error : int = ResourceSaver.save(save_path,save_res)
	print("error" + str(error))

func laden(path):
	var file = File.new()
	if not file.file_exists(path):
		print("load error")
		return
	var save_game =load(path)
	global.laden(save_game)
	for node in  get_tree().get_nodes_in_group("speichern"):
		node.laden(save_game)



