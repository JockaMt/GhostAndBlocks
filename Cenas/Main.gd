extends Node2D

var countdown = 3
var _min_interval = 2
var _max_interval = 3
var points = 0
var difficulty = 0
var playing = true
var vidas = 3

var color_1 = Color.dimgray
var color_2 = Color.lightseagreen
var color_3 = Color.steelblue
var color_4 = Color.slategray
var color_5 = Color.lightpink
var color_6 = Color(0.811765, 0.666667, 0.32549)

var positions = [Vector2(38, 16),Vector2(118, 16),Vector2(198, 16),Vector2(278, 16),Vector2(358, 16),Vector2(438, 16),Vector2(518, 16),Vector2(598, 16),Vector2(678, 16),]

var colors = [color_1, color_2, color_3, color_4, color_5, color_6]

export(PackedScene) var _squares
onready var sqr = _squares

export(NodePath) var _points
onready var text = get_node(_points) as Label

export(NodePath) var _timer
onready var tim = get_node(_timer) as Timer

export(NodePath) var _lifes
onready var lifes = get_node(_lifes) as Label

export(NodePath) var _highscore
onready var hs = get_node(_highscore) as Label

export(NodePath) var _music
onready var msc = get_node(_music) as TextureButton

export(NodePath) var _sfx
onready var sfx = get_node(_sfx) as TextureButton

signal _right
signal _left

func _ready():
	msc.pressed = Global.music_muted
	sfx.pressed = Global.sfx_muted
	randomize()
	colors.shuffle()
	$"CanvasLayer-2/ColorRect".color = colors[0]
	var _a = connect("_right", get_node("Player"), "right")
	var _b = connect("_left", get_node("Player"), "left")
	hs.text = str(Global.highscore)

func _process(_delta):
	lifes.text = str(vidas)

func changePoints(amount):
	points += amount
	text.text = str(points)
	var tw = get_node("CanvasLayer/Tween")
	tw.interpolate_property(text, "rect_scale", Vector2(1, 1), Vector2(1.25, 1.25), 0.1,Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tw.start()
	yield(tw, "tween_completed")
	tw.interpolate_property(text, "rect_scale", Vector2(1.25, 1.25), Vector2(1, 1), 0.1,Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tw.start()

func _difficulty_0():
	var a = sqr.instance()
	a.global_position = Vector2(rand_range(32, 688), -16)
	a.modulate = Color.white
	a.point = true
	a.speed = 500
	add_child(a)

func _difficulty_1():
	var a = sqr.instance()
	a.global_position = Vector2(rand_range(32, 688), -16)
	var choice = randi() % 100 + 1
	if choice >= 1 and choice <= 70:
		a.modulate = Color.white
		a.point = true
		a.speed = 500
		add_child(a)
	elif choice > 70 and choice < 98:
		a.modulate = Color.lightcoral
		a.enemy = true
		a.damage = 1
		a.speed = 800
		add_child(a)
	elif choice >= 98:
		a.life = true
		a.lifeAmount = 1
		a.modulate = Color.palegreen
		a.speed = 450
		add_child(a)

func _difficulty_2():
	var difficultor = randi() % 100
	if difficultor > 80:
		tim.stop()
		yield(get_tree().create_timer(0.8),"timeout")
		tim.start()
		var array = [0, 1, 2, 3, 4, 5, 6, 7, 8]
		var gap = randi() % 7
		array.remove(gap)
		array.remove(gap)
		array.remove(gap)
		for i in array:
			var a = sqr.instance()
			a.global_position = positions[i]
			a.modulate = Color.lightcoral
			a.enemy = true
			a.damage = 1
			a.speed = 800
			add_child(a)
	else:
		_difficulty_1()

func _add_square():
	if difficulty == 0:
		_difficulty_0()
		if points > 15:
			difficulty = 1
	elif difficulty == 1:
		_difficulty_1()
		if points > 100:
			difficulty = 2
	elif difficulty == 2:
		_difficulty_2()

func _on_Timer_timeout():
	if playing:
		if countdown > 0.8:
			countdown -= 0.08
		_add_square()
		tim.wait_time = countdown
	else:
		tim.stop()

func _on_Reload_pressed():
	Musics.unmute()
	get_tree().paused = false
	var _reload = get_tree().reload_current_scene()

func gameover():
	if playing:
		$CanvasLayer/GameOver.visible = true
		var tw = get_node("CanvasLayer/Tween")
		tw.interpolate_property($CanvasLayer/GameOver, "rect_scale", Vector2(1, 1), Vector2(1.15, 1.15), 0.1,Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tw.start()
		yield(tw, "tween_completed")
		tw.interpolate_property($CanvasLayer/GameOver, "rect_scale", Vector2(1.15, 1.15), Vector2(1, 1), 0.1,Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		tw.start()
		if points > Global.highscore:
			Global.highscore = points
			hs.text = str(Global.highscore)
			Global.save_game()
		playing = false

func _on_Home_pressed():
	Musics.mute()
	get_tree().paused = false
	var _menu = get_tree().change_scene("res://Cenas/Menu.tscn")

#-----Pausa-----
func _on_TextureButton3_toggled(button_pressed):
	Musics.paused(button_pressed)
	$CanvasLayer/Pause.visible = button_pressed
	get_tree().paused = button_pressed

func _on_right_pressed():
	emit_signal("_right", 1)

func _on_right_released():
	emit_signal("_right", 0)

func _on_left_pressed():
	emit_signal("_left", 1)

func _on_left_released():
	emit_signal("_left", 0)

func _on_TextureButton_toggled(button_pressed):
	Global.mute_music(button_pressed)

func _on_TextureButton2_toggled(button_pressed):
	Global.mute_sxf(button_pressed)
