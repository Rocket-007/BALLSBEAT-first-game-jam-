extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var balls = 0


var level = 0
var clicks = 0
var time = 0
#var sound = 0


onready var pause = $pause
onready var failed = $failed

signal new_highscore


func format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]
	var milliseconds := fmod(time, 1) * 100
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HBoxContainer/Label.text = "level: " + str(level)
	$HBoxContainer3/Label.text = "clicks: " + str(clicks)
#	$HBoxContainer4/Label.text = "sounds: " + str(sound) + "-" + str(balls)
	$HBoxContainer2/Label2.text = "time: " + format_seconds(time, false)
	
#	GlobalNode.configFile.set_value("Highest","level",level)
	if $allBalls.level > GlobalNode.configFile.get_value("Highest", "level"):
		emit_signal("new_highscore")


func check_high_score():
	if $allBalls.level > GlobalNode.configFile.get_value("Highest", "level"):
		GlobalNode.configFile.set_value("Highest","level",level)
		GlobalNode.configFile.set_value("Highest","clicks",clicks)
		GlobalNode.configFile.set_value("Highest","time",time)
		emit_signal("new_highscore")

		
	
func _input(event):
	if event is InputEventKey and event.scancode == KEY_Q:# and not event.echo:
		get_tree().paused = true
		pause.show()
		
		
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# For Windows
		get_tree().paused = true
		pause.show()
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		# For Android
		get_tree().paused = true
		pause.show()


func _on_resume_pressed():
	pause.hide()
	get_tree().paused = false

func _on_quit_pressed():
	check_high_score()
	GlobalNode.configFile.save(GlobalNode.file_to_save)
	
	get_tree().paused = false
	get_tree().change_scene("res://Scenes/Menu.tscn")





func _on_allBalls_failed():
	check_high_score()
	GlobalNode.configFile.save(GlobalNode.file_to_save)
	
	failed.show()
	get_tree().paused = true

#	i dont want you to do mistake and press 
#	wrong button while you are trying to get that hight score lol
	yield(get_tree().create_timer(0.8), "timeout")
	failed.get_child(1).disabled = false
	failed.get_child(2).disabled = false

func _on_retry_pressed():
	get_tree().change_scene("res://Scenes/Game.tscn")
	get_tree().paused = false


func _on_Game_new_highscore():
	$AnimatedSprite.visible = true
	$failed/Label2.visible = true
