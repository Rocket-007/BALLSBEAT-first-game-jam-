extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Button.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://Scenes/levels_button.tscn")


func _on_Button3_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# For Windows
		get_tree().change_scene("res://Scenes/Menu.tscn")

	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		# For Android
		get_tree().change_scene("res://Scenes/Menu.tscn")
