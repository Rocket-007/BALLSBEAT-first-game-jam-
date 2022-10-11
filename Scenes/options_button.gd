extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Button3.grab_focus()
	
	$VBoxContainer/HBoxContainer/Button.pressed = GlobalNode.configFile.get_value("Settings","music")
	$VBoxContainer/HBoxContainer/Button2.pressed = GlobalNode.configFile.get_value("Settings","sfx")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Button2_pressed():
	OS.shell_open("https://github.com/Rocket-007/BALLSBEAT-first-game-jam-")


func _on_Button3_pressed():
	get_tree().change_scene("res://Scenes/help_button.tscn")


func _on_Button4_pressed():
	OS.shell_open("https://rocket-007.itch.io/ballsbeat-first-jam-2022-godot")
#	get_tree().change_scene("res://Scenes/saveTEXT.tscn")


func _on_Button5_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# For Windows
		get_tree().change_scene("res://Scenes/Menu.tscn")

	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		# For Android
		get_tree().change_scene("res://Scenes/Menu.tscn")



func _on_Button_toggled(button_pressed):
#	print(button_pressed)
#	print($VBoxContainer/Button.pressed)
	GlobalNode.configFile.set_value("Settings","music",$VBoxContainer/HBoxContainer/Button.pressed)
	GlobalNode.configFile.save(GlobalNode.file_to_save)


func _on_Button2_toggled(button_pressed):
	GlobalNode.configFile.set_value("Settings","sfx",$VBoxContainer/HBoxContainer/Button2.pressed)
	GlobalNode.configFile.save(GlobalNode.file_to_save)
