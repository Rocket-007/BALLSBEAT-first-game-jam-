extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("fade")
	yield(get_tree().create_timer(3), "timeout")
#	$AnimationPlayer.play("fade out")
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://Scenes/Menu.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Intro_tree_exited():
#	GlobalNode.get_node("AudioStreamPlayer").play()
	pass
