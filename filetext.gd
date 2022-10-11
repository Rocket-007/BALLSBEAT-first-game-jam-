extends Control

var savePath = "user://datafile.txt"


#ready
#if file_exists(path)
#coin = load data


func _ready(): 
	pass

func saver(datatosave):
	var file = File.new()
	file.open(savePath, File.WRITE)
#	file.store_var(datatosave)
	file.store_string(datatosave)
	file.close()
	print("saved")
	
	
func loader():
	var file = File.new()
#	if not file.file_exists(savePath):
#		return false
	file.open(savePath, File.READ)
	var textinthefile = file.get_as_text()
	file.close()
	print("loaded")
	
	return textinthefile
	
	
	
func _on_savebutton_pressed():
	var ourtext = str($LineEdit.text)
	saver(ourtext)


func _on_loadbutton_pressed():
	$textshower.text = loader()
#	print(OS.get_data_dir())
   

func _on_Button5_pressed():
	get_tree().change_scene("res://Scenes/options_button.tscn")
