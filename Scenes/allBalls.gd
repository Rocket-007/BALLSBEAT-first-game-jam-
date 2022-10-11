extends Node2D


var debug = false




var death_bar
var power_bar

var level = 1
var clicks = 0
var time = 0
var count = 0

var max_ball_size = 2.3 #Vector2(3,3)
var min_ball_size = Vector2(0.746404, 0.746404)
#var min_ball_size = Vector2(0.597123, 0.597123)
#var min_ball_size = Vector2(0.477698, 0.477698)
#var min_ball_size = Vector2(0.382159, 0.382159)

var ball_level_interval = 2
var interval_count = ball_level_interval
#not using again
var max_balls = 5

signal allBallsClicked
signal levelComplete
signal failed



var hasExec = false


var colorArray = [
	Color.aqua, Color("fa8100"),#Color.orange,
	Color.blue, Color.gold, 
	Color.brown,Color.chartreuse, 
	Color.chocolate, Color.cornflower, 
	Color.darkgreen, Color.darkseagreen,#Color.cyan,#######
	Color.crimson, Color.darkorange,
	Color.deeppink, Color.slategray, 
	Color.red, Color.yellow
	
]
var prevColor = colorArray[0]
var nextColor = colorArray[1]

var colorIndex = 0


var all_sound = []


func displayOverlayDebugging():
	var overlay = get_parent().get_node("debug_overlay")
	overlay.add_stat("Level: ", self, "level", false)
	overlay.add_stat("#Balls: ", self, "get_child_count", true)
	overlay.add_stat("#Balls1 Speed: ", $Player, "speed", false)
	overlay.add_stat("Clicks: ", self, "clicks", false)
	

var newBall = preload("res://Scenes/Player.tscn")



func _ready():
	displayOverlayDebugging()
	var death_bar = get_parent().get_node("ProgressBar")
	
	for v in get_parent().get_node("all_sounds").get_children():
		all_sound.append(v)
	
	randomize()
	all_sound.shuffle()
	
	pass



func _process(delta):
	ball_level_interval = level
#	updating the time
	time += delta
	
	death_bar = get_parent().get_node("ProgressBar")
	power_bar = get_parent().get_node("ProgressBar2")
	
	failed(delta)
	
#	this it to check when we click all balls of same color then send signal
#	count = 0
	for v in get_children():
		if v.ballColor == nextColor:
			count += 1
			if count == get_child_count():
				emit_signal("allBallsClicked")
#				count = 1
#				count = 0
				break
		else:
			count = 0
			pass
			
	
	get_parent().balls = get_child_count()
	
	get_parent().level = level
	get_parent().clicks = clicks
#	get_parent().sound = count
	get_parent().time = time







func failed(dt):
	death_bar.value -= dt * 3 #20 secods i think
	if death_bar.value == 0 and !debug:
		emit_signal("failed")
		pass


func generate_level(level):
	get_parent().get_node("ColorRect").color = nextColor
	for v in get_children():
		v.prevColor = prevColor
		v.nextColor = nextColor
		v.ballColor = prevColor
		randomize()
		var l = level/0.2
		
		if v.get_node("Sprite2").get_scale() > min_ball_size:
			###########################################
	#		all this is the scaling function for the levels option - discontinued
			var randomVec = rand_range(0.90,0.90)
#			var randomVec = rand_range(0.8,0.8)
			v.get_node("CollisionShape2D").apply_scale(Vector2(randomVec, randomVec))
	#		v.get_node("Sprite").set_scale(Vector2(randomVec, randomVec))
			v.get_node("Sprite").set_scale(  v.get_node("Sprite").get_scale()  *  Vector2(randomVec, randomVec))
			var S_diff = v.get_node("Sprite2").get_scale()
			if v == get_child(0):
	#			print(S_diff)
				pass
	#		v.get_node("Sprite2").set_scale(Vector2(randomVec, randomVec))
			v.get_node("Sprite2").set_scale(  v.get_node("Sprite2").get_scale()  *  Vector2(randomVec, randomVec))
			if v == get_child(0):
#				print(S_diff)
				pass
			#####################################	
			
		v.get_node("Sprite").modulate = prevColor
		v.speed += 400
		v.hasExec = false
		
	
	
#	brah make it so ball is added every x levels
	if level == interval_count:
#		dont need this for now
		if true or get_child_count() < max_balls:
			var new_ball = newBall.instance()
			new_ball.set_position(Vector2(300, 500))
		#	very important###################################
			new_ball.connect("body_entered", new_ball, "_on_Player_body_entered")
			#######################################
			add_child(new_ball)
		interval_count += ball_level_interval





func _on_allBalls_allBallsClicked():
#	i think the signal is sent 60/s, gonna emit another signal, once this time
	if !hasExec:
		hasExec = true
		emit_signal("levelComplete")






func _on_allBalls_levelComplete():
	if colorIndex == colorArray.size()-2:
		colorIndex = 0
	else:
		colorIndex += 2
		
	prevColor = colorArray[colorIndex]
	nextColor = colorArray[colorIndex+1]
	
	
#	add out life baxk
	death_bar.value = 100
	
	level += 1
	
	generate_level(level)

	hasExec = false




func _on_Player_input_event(viewport, event, shape_idx):
	"""
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		var count = 0
		for v in get_children():
			if v.ballColor == nextColor:
				count += 1
				if count == get_child_count():
					emit_signal("allBallsClicked")
					count = 0
					break
			else:
				count = 0
"""
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
#		powerup checking
		pass
	pass

func game_over():
#	save
	pass
