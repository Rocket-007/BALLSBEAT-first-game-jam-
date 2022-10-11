extends RigidBody2D


var debug = true

var first_touch
var release

var startPlaying = false

export var bounce_limit = 7

var number_of_bounces = 0

var dir = 1
var speed = 1000

var hasExec = true
var hasDone = false

var prevColor
var nextColor
var ballColor

func _ready():
	randomize()
	dir = Vector2(rand_range(-1,1), rand_range(-1,1))
	
	prevColor = get_parent().prevColor
	nextColor = get_parent().nextColor

	ballColor = null

	randomize()
	
	var randomVec = get_parent().max_ball_size
	$CollisionShape2D.apply_scale(Vector2(randomVec, randomVec))
	$Sprite.apply_scale(Vector2(randomVec, randomVec))
	$Sprite2.apply_scale(Vector2(randomVec, randomVec))
	
	$Sprite.modulate = prevColor
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
	if (Input.is_action_just_pressed("Click")):
		first_touch = get_global_mouse_position()
	if (Input.is_action_just_released("Click")):
		release  = get_global_mouse_position()
#		var dir = -(release - first_touch).normalized()
	
#	this runs once on instancing; it sets us a random directional velocity
	if !hasDone:
		linear_velocity = dir * delta * speed
		hasDone = true

	if !hasExec:
		linear_velocity = Vector2(get_linear_velocity().normalized()) * delta * speed
		print(get_linear_velocity())
		hasExec = true



func _on_Player_body_entered(body):
	number_of_bounces += 1
	if body is RigidBody2D:
		if GlobalNode.configFile.get_value("Settings","sfx") == true:
			get_parent().get_parent().get_node("hit_sounds/AudioStreamPlayer").play()
		if ballColor == prevColor or body.ballColor == prevColor:
			body.get_node("Sprite").modulate = prevColor
			ballColor = prevColor
		get_parent().hasExec = false
		
		
	
	if (number_of_bounces > bounce_limit and debug == false):
		get_parent().remove_child(self)
		queue_free()



func _on_Player_input_event(viewport, event, shape_idx):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$Particles2D.emitting = true
		ballColor = nextColor
		$Sprite.modulate = nextColor
		
		#play a particular sound for ball depending on the index of both arrays [self & audio stream]
#		thinking of removing e shock you (dely at start)[1]
#		thinking of removing will you keep quiet(too long) [11]		
#		max is 11
		var max_sounds = get_parent().all_sound.size()
		if GlobalNode.configFile.get_value("Settings","sfx") == true:
			if get_parent().get_child_count() <= max_sounds:
				get_parent().all_sound[get_parent().get_children().find(self)].play()
			else:
	#			this (randi()%max_sounds) returns int from 0 - 9, i think
				get_parent().all_sound[(randi()%max_sounds)].play()
		

		
		get_parent().clicks += 1

